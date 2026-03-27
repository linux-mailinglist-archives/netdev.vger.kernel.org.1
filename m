Return-Path: <netdev+bounces-272610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HjDOhimxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:45:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFEA346F58
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00414300E719
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2825F2C11DE;
	Fri, 27 Mar 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="gRkYV2Dc";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WOKsP7g4"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10429A32D
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625992; cv=none; b=G0m+IDAqvO5mLwUhFPYnmhXdsDnfFuzAtOLZhrPDSd5Aekd8cYKqzg+ocIxlSyy6s0xoD2h07g2uAltUxRCPpdN1DrFkC1kKC9i7BAAyaPXoVdSjGOp7qLmCyeZ5hLYJuuR1uAckUNrwaMM09q8Col1/eDhUlmC2aSxkyV4+u8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625992; c=relaxed/simple;
	bh=TRzTq0GwbPZ/PdEq+U09xb7pJmp5jBiucbPCQ/6q9GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNs2WzL2iXdFiFUd/arQNn+jrD/yexbJqCCvD969yyOWmsSm737BedgUiNNm5QPDcsmaQd8/NVx6w12hO/aOyp0pmc1T21ncgW4ahac9I1P4L0uTA/vXUuC1VIi/sBG6pmtkDdQBdjCT55y3Lh75sHrrDanlwDdNw8YugIoqITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=gRkYV2Dc; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WOKsP7g4; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
DKIM-Signature: a=rsa-sha256; b=gRkYV2DclE8/X2HFxYmhQ0tvmrvZIL6pnqmPYsIgPyg6LsGfuJCGn9AXX0G32AMnnpQHVcM5oatay6JGeSM0yEW5EDxWeviSDx+8SntzwGsQoURoMp30NbUw6qR8QIpPx58gM8xTLnkt7wMrfMNT13gqk3uAEmW2KgWpnJUp4J/081VWy9pCaNsJz+Ghyo009LkWdP8Cd+UEUmvIPAxs3M682MDlQMHMkBFlIcI86g36S8JT36CjTuQ+yCEsuNSMuiGgOE2BvLXDrkINICjgtJ7b7Jmrq0kTIKUCpDprgG+2b6ivkNTtjecPMDLiGxHDpkZ8EuADjRR0mCqp0qOusw==; s=purelymail1; d=tinyisr.com; v=1; bh=TRzTq0GwbPZ/PdEq+U09xb7pJmp5jBiucbPCQ/6q9GQ=; h=Received:Date:From:To:Subject;
DKIM-Signature: a=rsa-sha256; b=WOKsP7g411YQDxCZwuSWT1oGZHPhcdFsalhp139Ipmp+KhLXzLL3UNf6atfdW6X3zUxul4rUuGxcKEIZPOYZ/1UPKR/HHdL7uRKxQ2RLgMpRxSvtz1lo2lFBZFUGE71tWu9L3jKV6NH6j32uuJ6t109iT9zTLy7g4DBvH9oIZ+EEFF3YRQJ9R/48zarWuLB4z1rUsaUuzGdn/7rUuRWjNYVBO1zmKWwTljPRVPcGvVsVgwdhl5OMEPWnqHCjot4W6cSgatIqF0rCkNS8L7rE4WXwvcPre83gWvPdTRLIgHZvRWgs2267ODygrA/NI7lPJGwIhj9Cys9kbwm8oWw7sg==; s=purelymail1; d=purelymail.com; v=1; bh=TRzTq0GwbPZ/PdEq+U09xb7pJmp5jBiucbPCQ/6q9GQ=; h=Feedback-ID:Received:Date:From:To:Subject;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 929034348;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 27 Mar 2026 15:39:44 +0000 (UTC)
Date: Fri, 27 Mar 2026 17:39:32 +0200
From: Joris Vaisvila <joey@tinyisr.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com, 
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net, olteanv@gmail.com, 
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next 4/4] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <acaj0K1EevnhU-Bw@archlinux>
References: <20260326204413.3317584-1-joey@tinyisr.com>
 <20260326204413.3317584-5-joey@tinyisr.com>
 <e6d91e11-fe19-48c0-886f-e1c0c92b094d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d91e11-fe19-48c0-886f-e1c0c92b094d@lunn.ch>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail1,purelymail.com:s=purelymail1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-272610-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purelymail.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tinyisr.com:dkim]
X-Rspamd-Queue-Id: 6DFEA346F58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the review, will fix all of these in v2. 


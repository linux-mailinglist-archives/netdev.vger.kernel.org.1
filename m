Return-Path: <netdev+bounces-259474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MZrFkwZl2nKugIAu9opvQ
	(envelope-from <netdev+bounces-259474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:08:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E4815F56D
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC1633013709
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB8433DEC2;
	Thu, 19 Feb 2026 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPlknnkX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q422zGdR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AE33A9F3
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771510017; cv=none; b=S6Bk22i+GpfK8Lgn0UV59AhrRmVUOQAqPO+SUxE3sMa8xI3qQF2mEDusMes+4mOOvnZHcPKCBs6IS2oiJ02lujxty7W841Mf/cE1ClFy5lWjd2qlcXT9TrkvU/aRaV5GqjBrWKsUummbsMIejtCxGuEC/Y64J4By0fSwD73+uJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771510017; c=relaxed/simple;
	bh=jbwjG+wlfbHA1sBVc4a/Lk42FcEv/YYGo1s4g4cDdEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kceC0O/MbBXKYGpu/IbLFYRSd6hUHjGO7YnLb9oaOHaSQsr3pB69phs6gYY1nmu9T59P4tXPeo12WQtoTMH8iKCLpk3MeLqhlIBt1CRP/ggS5AV7tM68sA/CrwNKtr0N4QXHEYYUrxsVjhSB9GjQJXgR1234DAq7B/g+vA/topk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPlknnkX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q422zGdR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771510013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qHS6NPE0XCB+V5xU3uCNJPVD0Vb+HittHqs9HXFDi8M=;
	b=cPlknnkXKAWCVET4xrDZp9qaYigcQJhm8vo5FDj73ay6f0VSc/9GNzTNO5Br+F9Hxj+WCu
	TwnPf3FZulIlgef35mDEqwxEVYO8ySm9xDQik3JzvtRg3DiM5F1YpuMQJnjQMl+4fnQD4m
	xQaWRLNYDCC1P+fTitzu1TxCdlK4eGk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ls6o1bXSNZ-lUzSoIAKTwQ-1; Thu, 19 Feb 2026 09:06:52 -0500
X-MC-Unique: ls6o1bXSNZ-lUzSoIAKTwQ-1
X-Mimecast-MFC-AGG-ID: ls6o1bXSNZ-lUzSoIAKTwQ_1771510011
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48069a43217so9014545e9.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 06:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771510011; x=1772114811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qHS6NPE0XCB+V5xU3uCNJPVD0Vb+HittHqs9HXFDi8M=;
        b=q422zGdRI+aLHYzCk33aZ+wg0/455ah4bH7Oa86jecmOjsuWnXhBkXfzzxKcGvs8j3
         y5s1kRN02rGbhBhHLN2MgB45NPMuhjt6qQLL0j4OsgE6hcE/0JU6A8o+ex4/4z8rZubS
         lyox9pi4ktdChXX/aTucjbd+158/3+YDlMNapftHsRnsaahhQBGdnMwI1+mC4Fs7HzY4
         9YwNlVwfgy3HXmprURsiCn8z4N7MWYR8gtCyHQ6XnJkzhbMiaJFEiDwp/Xg9Ql+tUmuY
         T7M9XqNyNdbBw8YsSHpR4Kkwco3db99U4y0tM02v2sp/rizzc+49dJ34yXCWNjVhUxwA
         ubIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771510011; x=1772114811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHS6NPE0XCB+V5xU3uCNJPVD0Vb+HittHqs9HXFDi8M=;
        b=dkge7VJ7wBwr73Mc/08/tvXqkuLxE254qwgMv3DQ48Uf+0qhUTMXwvy8+QgeD3G1b8
         iAMFgRTBi7d+iSVKsxOx7H1zWnfkGH6tYgw1nkn5W66Bwi1nNM+kKqTm7PpfYWwGrMrw
         aySn9wLsucwQnX/+2EtiWUNB0JrGnX7B6w2fm8JETOlZ1k8VFIJrZLfiS9PNW6vzjDXG
         N0k2u1zPpb89dFaAuikO9EHsVsED0AF0qgTdFf++nWzNnJJ6u1ci7U3jKo0/8F+y4W9E
         Ryu8wRnwP65DeCKjIMW7aNWlszIujRhXZTuTJWJRnKyH00qVOxOL1Tvdl/LXv1LwBcmH
         OGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhkzXZiTlIN41hed94qaQSo7xld1iyGqVbt6FzJ2E/uZTxfl3gpTRH4SIEQxaSZX/D17gyAcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsZzJJs5SZlwfcjBFVQuIdvGcqluppWeDv5BtKNOOnI9jdz25
	9ktJQOZEZTYcjdwMVApyvVTQNqgeHTu4CeO8Oa49Fv2gtpnmWspy7S14GQs1F3TbHHKhpBcbBsn
	E9DxfrZuElbpL1os3vLgGSunQsesEi1hA8zrMWCOksxvhElBa7ieMGKo1TA==
X-Gm-Gg: AZuq6aI7/5DaEwyxjMOCCBRonPTBIkXXkmx368+nZ60Cj39Q8MMA7rY7mmjUP3PRvYI
	+aiHmBIer/eamGSv2avYZF51Ch3v1iQSGJhTrY+lCsEcGbt/xupX1dhgR+fFNoEgb+4Gg638a+r
	Af+lGFmBSjz9DWAHan8YmTHRIATfQWs8RDR1yaMY6ZYcNL/d1jwTp9LK6bxl1it7m37QRAPFLY/
	5szvDj+Btoy/SW0tPs4swafKzejr7cBx6Sx1+SD+1L8d5SXdXG6WlQiIxKCiSWh4jnNTEBsFGNp
	1wflApbw9e/ayAiMRh4BdLJWyof5+2dbPprgr/GNid3ywnNRQB0j9T1LOttYvucqh3gQO1gjdY6
	gWERGfwswHA==
X-Received: by 2002:a05:600c:548e:b0:480:6dff:e786 with SMTP id 5b1f17b1804b1-48379bff816mr296563705e9.37.1771510011111;
        Thu, 19 Feb 2026 06:06:51 -0800 (PST)
X-Received: by 2002:a05:600c:548e:b0:480:6dff:e786 with SMTP id 5b1f17b1804b1-48379bff816mr296563195e9.37.1771510010565;
        Thu, 19 Feb 2026 06:06:50 -0800 (PST)
Received: from debian ([2001:4649:fcb8:0:7ef1:6110:bb21:b83a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31b1d79sm16276135e9.3.2026.02.19.06.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 06:06:49 -0800 (PST)
Date: Thu, 19 Feb 2026 15:06:46 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: linux-ppp@vger.kernel.org, Michal Ostrowski <mostrows@earthlink.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michal Ostrowski <mostrows@gmail.com>,
	Dianne Skoll <dianne@skoll.ca>, Paul Mackerras <paulus@ozlabs.org>,
	Jaco Kroon <jaco@uls.co.za>,
	James Carlson <carlsonj@workingcode.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC net-next v2] pppoe: remove kernel-mode relay support
Message-ID: <aZcY9l35A-Yw8NYH@debian>
References: <20260213091605.132561-1-dqfext@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213091605.132561-1-dqfext@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259474-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,earthlink.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,skoll.ca,ozlabs.org,uls.co.za,workingcode.com,arndb.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnault@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B5E4815F56D
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 05:16:04PM +0800, Qingfang Deng wrote:
> The kernel-mode PPPoE relay feature and its two associated ioctls
> (PPPOEIOCSFWD and PPPOEIOCDFWD) are not used by any existing userspace
> PPPoE implementations. The most commonly-used package, RP-PPPoE [1],
> handles the relaying entirely in userspace.
> 
> This legacy code has remained in the driver since its introduction in
> kernel 2.3.99-pre7 for over two decades, but has served no practical
> purpose.

Also, this code was broken since its inception up to 2016, as it did
leak a socket reference in the normal data path (see commit 29e73269aa4d
("pppoe: fix reference counting in PPPoE proxy")). The bug was caught
by code inspection, which strongly suggests that nobody tried to use it
before that.

> Remove the unused relay code.

Reviewed-by: Guillaume Nault <gnault@redhat.com>



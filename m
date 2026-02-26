Return-Path: <netdev+bounces-261169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ+YJH6/n2lOdgQAu9opvQ
	(envelope-from <netdev+bounces-261169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:35:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 407D11A0979
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7815830217C8
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE09D376BCC;
	Thu, 26 Feb 2026 03:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mncs82j6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17BE37107C
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772076922; cv=none; b=sRRBpPfUOeVioLsS80P+uJIwEznoEhIxsVBX3QawrjwuecZFxtH06dmSR8FXv5wBjyhZ3kuQ+JJSAdVxv0QwDEfDM6FzuUyAXxbbl4JF+sbrL2dn96bVv4A/mwbENAchbOVc5yGQycxTbcx6o7iIok99IAy2mWUs8NGRwRTg+o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772076922; c=relaxed/simple;
	bh=uqz1X8JWXcmuSebGOSTEBe+xZQkqE6fRQ7dX34NczAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEPPlW3VCMNSopddxR+viWQklZBlg5IbDvAaDEaW1EM2UBXBESBnAtOyPs0jOa4KRxkvPdpNYdJe35qrntwyC9/A/cYsQ5adBvsHlbveQHlM5VAWEK64KcwabYf+W0z6v5vazdHSmT5v5iyb/cWJeghlmySKK9qrEoXNJ4TvN5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mncs82j6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2adbd435864so1192605ad.2
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 19:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772076921; x=1772681721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PFyzhzrOIqLe01H8C/oaTtI2liVPl6db/VAGpp23hXQ=;
        b=mncs82j6LfhcvsYsSYv3ltx/1KjCehYf/WmogKabFmq/dRD91EN6L6niKZonuXOzGr
         eXmJ3siK8lXnmcVlBZV4gfpOJAOa8VwmV2JkZCE3yzfTUNUhW2QCIHz4IUNBAJe6DXDI
         MwqUutYyswdS0B+eSNu4MAvYb5pJ+eThKwOE46iNbrhQA+iUgHAhvnYYCqfKdaZoO/tj
         n26G1F3bIeXJHJQkP9lc5bs3fiu9wAgDA0InFmmUxg1fUG+v1HXQkkM0KyLVzo++ZVte
         3ZsVome/wMD5X9KW3x4UJpZaJjfHPC6CVnL6bLjdfhXB71y2Tkva21OaWvyMYsukc9w4
         CO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772076921; x=1772681721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFyzhzrOIqLe01H8C/oaTtI2liVPl6db/VAGpp23hXQ=;
        b=GwJomh+2At83qMHxeqWIVzadNw2QA+MKnzp7ZK6dPSQtPqxikrG7afovK9I1mmm4am
         c94S58EMVi3p2ySvl17WOtJvuy4C2jxL/kYRlqraLmN2ahruEOTluwVDh4lGx0AIIOQK
         boUK3XgEqEzcVXZ7tZ9KDUc4pzn+A0XCyS8i0qGXiUNwYAg6rZF+zXATKK716gGc9n4X
         XeW4heBLoA1LEp7WumMIrchN6R9YrBRSl6HU9CT168C9qx5OQRtzvbEFic2aT6CU2tK7
         PBAuklGvT/rf42qemXip8NoPbqQP5KzomqwF+8orGL1+UQZgJh6x11UC2i5pWZSvQk/n
         MwLg==
X-Forwarded-Encrypted: i=1; AJvYcCVkDE6AVtrNZxbIKSHCZoonvA05DyL1L4dwU5M6szY+x3luprMfORiu/GmgA/q09kYI3tV0gek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+lb6+QpndS1eDAOJr2ynDgv+wvHWGyaUl+MA6AzGOR/0Bfwz
	fSDBqxeyOPGvyfX/zPMciQ8Ocj8g3+Pjn/2Nd69qZQSRc8J7fjJxGCS4
X-Gm-Gg: ATEYQzze3OUS0+hhtpRnhwL6w8+dq7/iWQgzo0Bt5/BBjKi+1AxeoNskJxM6itSbuE5
	buwyEN6u2HXNqnjUoPxgxF9mXgfGLjZME+KZxsL4LRB1jGhd3BlOYuytZM5m8pgis4UiJBaZr+A
	iQ9NRhwxnx/+MAtc6dwP40E9X/GO+oeCVNmfpkdfyXbetEnhaO+POu+vzKDYO634PRLnWPU+rcM
	WdX+TOZwIaIlwYVPR3IIdxx45mC3KA5Pdz/j+xJQ52iI673NO3vJaAwOCBR4gAih2i5KWTRVjJj
	EAgwnxfa/vF3E8z+90KfUIVR1+FhaH199qhgNyqwhJYsp3lsRG++qSdyXT5rZPWNf9Tf/VLjq0g
	7sTVbDJDjkyipDcSVrKJgtGu99KTFflD6EeOXcZ9EjzYKrDRRQhLcjr3Nl0vTg9ZYnJxkab+i/j
	FuU45e32VvO2QyxHMXsChIRQtVe97sp2g5Am8Baw==
X-Received: by 2002:a17:903:3bc8:b0:2a7:561e:690d with SMTP id d9443c01a7336-2ad74556ee6mr167660155ad.46.1772076921216;
        Wed, 25 Feb 2026 19:35:21 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f277sm9647825ad.55.2026.02.25.19.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 19:35:20 -0800 (PST)
Date: Thu, 26 Feb 2026 03:35:14 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next] iplink: bond_slave: print actor and
 partner churn state
Message-ID: <aZ-_cno3VBau66_M@fedora>
References: <20260224020215.6012-1-liuhangbin@gmail.com>
 <20260224020215.6012-2-liuhangbin@gmail.com>
 <20260225132239.34fba967@phoenix.local>
 <aZ-rjaU32FbTbn9I@fedora>
 <20260225190333.16fdb616@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225190333.16fdb616@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261169-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 407D11A0979
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 07:03:33PM -0800, Jakub Kicinski wrote:
> On Thu, 26 Feb 2026 02:10:21 +0000 Hangbin Liu wrote:
> > > You should use print_uint for unsigned values.  
> > 
> > Thanks, should I post a v2 version for both the kernel and iproute2 patches,
> > Or just the iproute2 patch?
> 
> Just iproute2, they aren't bundled by patchwork (please refer to 
> the netdev maintainer faq for the correct way to co-post iproute2)

Got it. I will post the iproute2 as a new series.


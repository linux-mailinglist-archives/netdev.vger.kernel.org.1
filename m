Return-Path: <netdev+bounces-272668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J5PAAbhxmnAPgUAu9opvQ
	(envelope-from <netdev+bounces-272668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:56:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D3534A888
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 555413009B08
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679AC37EFEE;
	Fri, 27 Mar 2026 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfMJmFwr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808518DB26
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774641411; cv=none; b=BJcd5LAKQSviGEPUJB6knE17YaqHF+PXO9dSbyfEEpw0AsmuXE1BVvqFiJM3cYr4CGC7VyUW8wgMp4k9KEZfwLi3eX5Ey52G9/1q3t3/Z9bOZ0/Ue8cJbyb3a/GOQ0TwbbuLWZ1HqJ4RmBJ26qB1vrDUa+eLMT7/nme3rfmJDE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774641411; c=relaxed/simple;
	bh=g2A1VodOn7M/F58Dvqm/kjBtZoSx4LJs+OGd3ZNIn1w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IUzXaz9SxEC+GH40zFe2ymbGodt2m2FkFKbeSlXCfVJh6MJitiyolqNwkk4exP8MoGaBPoWiyDXBCz1LlR2Q5lvaek7HfPa0Hlp46OL49rUJYr66FrxRwqZ0SouU6HJ0s3GqzJhaoUQvtUbOT9ebVDqMYQ1mGgwLfsnDw+tXu78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfMJmFwr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79ab5fd969aso28430427b3.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 12:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774641409; x=1775246209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li4dRdJMGvbSuyBJNoyrYjziCM6PRkPOEGU91wNCK34=;
        b=lfMJmFwr6P0oyTXAQxJBMlAk3b5tqm6tMeMHlDs5s+DeS51Mr/Of+x5/8M+3aQQiBy
         IAw7xQ/kLfJaSaNaL+fi7zxts0mCjLhTgSMNfGtLRdr2rehMXO4TPGdZ5pxNM5lcdNPP
         83K1B3Wx2Cf99zzlAP00nCkDzdahX9K9LuNaNh2oYQVSCIiIV+Oxc5fsW619a4A7mIWc
         0/Az3nWmBCwBeLdHw6Y4w2vVPtGnKTC4VY9uk8JkiSGoj9bRDA2RGcS3K2drV9xF2hPn
         J6y4A0NewtLd0rQn3I7PNTEH6tYGVGcVaS4NX3i3HM6An2kSLBinfRWhm/V0G6OOFMfy
         CZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774641409; x=1775246209;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=li4dRdJMGvbSuyBJNoyrYjziCM6PRkPOEGU91wNCK34=;
        b=MmOerEfNpIKGU/oFDKi4xGBVUUO6SzkOtOdVmc0VwGmwli2lUAiy/tGfCluxIHFEEA
         +mfdyKU4RZrmJ309ImSHlS27oEg1Sncub0jCnrNTMyhphfj6lhC/TBi7+BiQ+lGBttCb
         a+PbV/8RlZc3AYvSrF7e8diDevF6zPSUwXJcioNpwDszj7PIHPn9trFZtITdZAgkDMxg
         /x37MUUoCVqABdg8p/W7Cc9JkGP4EMvIN/Rfwcav04HmGfPu+VGuRlK+/sYSFjP4MQMx
         C6DqUgPMKGBv7YgVfQIzghobp4COLtkJ/N4hfhFBHRBIgRKYB6/ZDygtghzrhVy5030l
         BFKw==
X-Forwarded-Encrypted: i=1; AJvYcCWDbEkLDj2VgkNxtK++U9DgDxbldnnWf75A1da9NJxIq6uPDCAyqWDAeFHEHZbYTOPxO8ZPmXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJHWVcVyTluRKXd8IvSWkzg3etfdBUByzpq1a3+ZuFFclqT0HH
	w+VEnrw2YJ+SvwZevig0EmlLGm0TDLWLoWCBEQD6e91B01H6SsFzwrv8
X-Gm-Gg: ATEYQzznENjWtLwkYkpEzQeq12c12HYGJO6IZJ0ZxbKHWHwL961efk0Ylcu1HRdRKBL
	FFv/FaTuka56Oag5raVQjNBTTtctYnhB/uMNKkD7QUg0efaAUvzFMmk3uBzD/uc51GybXnfK5uU
	156dIBh+ugfmu+7uo2WbD78dYbyu8t0z5Ximk/sh3Z7dEKU/GQb+Xlxw54+YKrFj1T82q13G2HI
	7Zwl7o7hT0oHIW+PId43NvC5rWMuUTIgCDPqMBnRxPWyd/IRJoLBlAdjWPg39VT2v3c/xnvCbZk
	4hQ/Qx/mXOUAdBUvMgJtJuKphmZ7lkHXCVTnyvXygTsMovpJV/VtqWDsFgg2JQ82XWyvyoa6z3/
	qx2/lVntBVBDHOZJjt6mzecxU2OV2xSeWa0FcHfz5+6HNSjMmVUuvmVAGSt8pC4xA9oDOF/zYJ3
	mKXqkHLiXHqaSsZwSkfhD6Sphd+V24j03vMAAsZsFKodSnqpSNju4tl5xvStJ3cmUXV4jUHHZ3r
	4m5
X-Received: by 2002:a05:690c:e3e5:b0:79a:c396:bfb with SMTP id 00721157ae682-79bde0442f6mr36548767b3.43.1774641409099;
        Fri, 27 Mar 2026 12:56:49 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b1e3bec5dsm35125117b3.25.2026.03.27.12.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:56:48 -0700 (PDT)
Date: Fri, 27 Mar 2026 15:56:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Guoyu Su <yss2813483011xxl@gmail.com>, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org, 
 horms@kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, 
 syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com, 
 Guoyu Su <yss2813483011xxl@gmail.com>
Message-ID: <willemdebruijn.kernel.2b1d9c22eab26@gmail.com>
In-Reply-To: <20260327153507.39742-1-yss2813483011xxl@gmail.com>
References: <willemdebruijn.kernel.19f0cde3c6457@gmail.com>
 <20260327153507.39742-1-yss2813483011xxl@gmail.com>
Subject: Re: [PATCH net v7] net: use skb_header_pointer() for TCPv4 GSO
 frag_off check
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272668-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,googlegroups.com,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,google.com,davemloft.net,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 62D3534A888
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guoyu Su wrote:
> Syzbot reported a KMSAN uninit-value warning in gso_features_check()
> called from netif_skb_features() [1].
> 
> gso_features_check() reads iph->frag_off to decide whether to clear
> mangleid_features. Accessing the IPv4 header via ip_hdr()/inner_ip_hdr()
> can rely on skb header offsets that are not always safe for direct
> dereference on packets injected from PF_PACKET paths.
> 
> Use skb_header_pointer() for the TCPv4 frag_off check so the header read
> is robust whether data is already linear or needs copying.
> 
> [1] https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
> 
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.1a9f35039caab@gmail.com/
> Fixes: cbc53e08a793 ("GSO: Add GSO type for fixed IPv4 ID")
> Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
> Tested-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
> Signed-off-by: Guoyu Su <yss2813483011xxl@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Sashiko asks about similar inner_ip_hdr in skb_gso_has_extension_hdr,
but userspace cannot set skb->encapsulation, so that's a false positive.


Return-Path: <netdev+bounces-263419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFyZK/JNp2nKggAAu9opvQ
	(envelope-from <netdev+bounces-263419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:09:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8F71F7318
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA0683020A4E
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F4B372EF1;
	Tue,  3 Mar 2026 21:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="Vntv1qKb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0123121FF4C
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571847; cv=none; b=gLg8BKuZ3lxaRGJPnRZQ2k5AKzJS/nZ6Yhgqzg2y50psP+p4om8+1xfegQDokuDZW87QlMfsPBEn0hHhQKnF5BFhQpsbZUWvBM2BiQ1sMStHAJe+WQ78EJnV0f4jhS1OLNSacN9NezbYswOk3OaO2UBEAYV/08TAYrcR7u+MxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571847; c=relaxed/simple;
	bh=J6nDxFAmQuO1PEmxWaxGzQ5kcCpDKZy+Jnp91XAOmyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7Sbp/eLsMSjvbWs4/Id4DtXt2Jf3tsT0neEArAjB5W9g4eHyzZ0Z82PhNg4uq8sf/EC4nSrwnesdLaNqOBB/w+ejxhy60PiS5HY681IyELrC9yaY7n4Efadaj3aT/1q5uNyj83ASpyuHKPNg3j5YEvK7Wl8Iz1Tr2ayOujc5x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=Vntv1qKb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6e1f417918so1832937a12.3
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 13:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772571845; x=1773176645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0z9fzge2OCGffz7dX5wu5y2qLO9lb4LYFW2zmtJVxI=;
        b=Vntv1qKb1bp8CmvaXVtEBUatxXODyBYSl/+F/wrf9nSnao7+e7zvNMCNMZPN4vpInp
         Yj/XxeD5VMZ8vRdDMbSk2/YZqMPRcFJ9VcKsG7U0t/Fq/3c4L2fXjnWiwJNUFOz3AhRd
         zY89xZRe2I0uG9Ccgf2Ywhr9801jm9w4hk2cq04adRYPdoVb+IOsObfc9PNLfEFL3oSg
         lYoJBl0kjoZXHlWw/nM7kn5vWoR3xNx5H3SgmOGCNy/dk5aWrfQeS6Dwe9dDMNHE9pKc
         u/HmQoLgCrWqr3IDiokJEzEoPHgVUzNSSX2T9G4a+DNfX5kP9P6rCyWfE23UXgCpJXsH
         GKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772571845; x=1773176645;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X0z9fzge2OCGffz7dX5wu5y2qLO9lb4LYFW2zmtJVxI=;
        b=kUYn/RBKZUeVitRePWzARj/EkFMdUXv5xv/fcIwu31joRRY/J20EbRDg5yi3KxdiAd
         EGwHv5w8iy693t8OtGELzMwm8xrZnXJt8bml24WIzdGQwgN+nbX1Dcs8K6HBzEsQ5N3k
         hWznVfv+yunx8c+Xe09jisX7aojBoNKmx2ANgOX+rtaEfPw+0emf94l/YMpdHnt0AAtA
         uUYT5MtaRJs7CH3VIV8Qkf6wQrwdZSFNG6fn2FU74kxRrm49CknEN0r0GYFeYIFt5+Qs
         TB1/XoQFqMjt1FHsf36OobWYJDpVvXXeTeldVFa9JJ4SbszoSqSUKqt56TQZCYSj168i
         UESQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT4Ph65WOKNJUO3kwc93zG/6JDRoHI31r9e9b3yVGBv5PGuSTZXJoiFBZQ+SpPl1w65Whp/9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUnt12Pa8GdrgaNccCAaUrqQCJlstVmsgMwYAPXjXZpLSf17w
	+/yj+0QTboDAIXRtZ16VVbseM82Gwi+O7EWCLeaayuWzwrpDAIR28khiI+HXwE/G4ABXOB0V6vU
	oc/PCot0=
X-Gm-Gg: ATEYQzyqC5EtIhMjPYa6HxApJXbXYxTD4ooNHQ0rwjnyKfMmRgLmbR6fTSsA6+wNZC5
	VeCn1rcKgFEDZuX9IyrvVO+nXlQHB5MEPy3n4U8aPH+AhG1I/RHbgraAl9yykSlSwqJf75TXMYs
	nc4390m7r/dzCQUQcNpaPAIm0jJ6Kb8+lBgrEHtNStVH+7eiAH0Y77DHXzoK0Jn2ZKIfnorYjbs
	Yo7sh4B4MsfqsUN5nADCznM5veeYj2HqSzJVbTRiRzlY7bvn8/VrRJ391I20wo/4Ok1brU3Npcv
	pxO7BECKop5CV/hpx+7zsIeFhvDqgO8eRNXO3V/sYQAnc804VV0tSZzjfvO9voJpWme5QYcTH+j
	frwB8757mLsH7j2+3NUVEaV34VRnAQV8fi/BfOLeKiFhV0kUK6yfJR4j69pbIWWIt/TQYjByTKE
	ukNHbc
X-Received: by 2002:a17:903:2303:b0:2ae:6887:5c26 with SMTP id d9443c01a7336-2ae688763fbmr5513245ad.48.1772571845308;
        Tue, 03 Mar 2026 13:04:05 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3e4e34fesm108107565ad.28.2026.03.03.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 13:04:04 -0800 (PST)
Date: Tue, 3 Mar 2026 13:04:04 -0800
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net 2/5] nfc: digital: free skb on digital_in_send error
 paths
Message-ID: <aadMxASFz1a/Ls8U@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20260303162346.2071888-1-kuba@kernel.org>
 <20260303162346.2071888-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303162346.2071888-3-kuba@kernel.org>
X-Rspamd-Queue-Id: 0B8F71F7318
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263419-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dama.to:email]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 08:23:42AM -0800, Jakub Kicinski wrote:
> digital_in_send() takes ownership of the skb passed by the caller
> (nfc_data_exchange), make sure it's freed on all error paths.
> 
> Found looking around the real driver for similar bugs to the one
> just fixed in nci.
> 
> Fixes: 7d0911c02fa2 ("NFC: digital: Add NFC-DEP Initiator-side send/receive support")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/nfc/digital_core.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>


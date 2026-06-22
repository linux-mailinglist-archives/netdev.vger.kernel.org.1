Return-Path: <netdev+bounces-301165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DnybG5hhOWpnrQcAu9opvQ
	(envelope-from <netdev+bounces-301165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:23:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD46B119F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 18:23:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=XlSpV4X2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301165-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301165-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEF2F30071CA
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B882DE6E3;
	Mon, 22 Jun 2026 16:20:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A411AE877
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:20:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782145237; cv=pass; b=CUCr36XWn/uB/K/Towd4ZdCOUylUlviNEWNvR7LdwNe3qNBUU0bzJQ77MP0KJzN4b0hkh2ludJ4cpHzyKJn+4Ge8F4zDE99XC5QUY3mFPUE2qMaKyXU9XZF1EX/MTZvJdiWYKLxhBYiPVFKx0AeCmLKU0N/3vHP0XOE58jdanpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782145237; c=relaxed/simple;
	bh=d2s41L5jEoLolC/wFtH4H+ngMP+cqu+AY2cetSGdFzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayQCMO+2+lbhzTNemiGITgjXvl1Ra6JvJQ8UH+NGV5glyS+mQero00nmA1X9NScDlsopvkbd5zFd9SYLuvGazAYYwnGMpoTJyivOpEBEvBfVcTnEftHv0vq82xzsgRtk6PvjYcqorqn8fNp2LOPjbhWB6vfrgCcG0S4fjsSLA8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XlSpV4X2; arc=pass smtp.client-ip=74.125.82.46
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1384ebe7a10so3487584c88.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 09:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782145235; cv=none;
        d=google.com; s=arc-20240605;
        b=iMHzpFiTwb2sOZBzVpSCj8IVhrRdh6fD+Nugi6vjZHViw4OkvbM2j8+b72fctw0eYJ
         16Os/kgfb+Sr0smJylq2d1VJtIaLkPv9Gk2K5BPrZ1MvZrGVBrsAhg7l15yIQbFvLB7U
         fOCC3/2Lc4bgECvmJD+9HSILGGt3HZtw19IwpVg8nxszRMdZWLjaa2wBzbwKUAN6qg47
         wYKQ3clEJoRDvOS0YcvO6ned2YyIJdWjSLsIm7nR+TY2wkgcCVtW9sZtiyzYe0qR7y02
         XKodiwnmaTJDKiKHYIJdy4oxm1zv9jZwjsflqJChjvOM3LFYyhQxxUn733G45OWR4U9l
         KBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d2s41L5jEoLolC/wFtH4H+ngMP+cqu+AY2cetSGdFzI=;
        fh=4USqmIRJo94Kx7vYdunryCg9LnjhplfQApHAXNkEAp8=;
        b=XD3j+9aBz2SjOpEPuUsCh56qCMKbj9fM+YeQzP9lfLkOO0Mkd48xSj+gO9cbF+VWnY
         ElLP+IwS0bgOemlSwo0DCGxR3quKMR5AmXKTMOMeucUEqR/7g7a1GtrLAOCOYrC0rnOa
         kwxeiIFcSgLTPmwcrBcYqsaOJloNyRIXhAymlpreq2hgv5i6IY81HPgLr8iyrRriWDGg
         Dhji41xbd+94tnMmcoBK97NvmorvijFomzmWKRDK4rLEOdFTD8whuNWJVm7uca/As9cA
         5sCFwySWlLFD/MCA20Y3YhtlanylicOo/I1/uH4Io38TXW47z2UbbfzLwk5p675+lPFU
         Eieg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782145235; x=1782750035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2s41L5jEoLolC/wFtH4H+ngMP+cqu+AY2cetSGdFzI=;
        b=XlSpV4X25p62keVDC++kdLGPFSN7/o4k5EImXm2y7R7EDMifxlHsjwvgHbP7k3d+vR
         Tfr0j1dHgvgtmyCij18RwJy5wWKmJAwWdf8bH+eFVcmkP4F1XnBDpCVVDVo33sbkK7ot
         e0EiYP617Oe75SDoTqHWLaLgYg/SORLnx/kzv90X8ZUEtOir259CvCn9ByT+S+e9MTmZ
         ONAg4PkSV9TUmP3QfSTWHJ/Cb0X5cDyn+yHSLlc0M3CUkRCWEEaa80GavttgOolfJElq
         mPKpKgbSBrX9oWOwhMcR+0UM+AuO5HiJVN8wjgwtEIhLzjUhcJu1uiCtPxK/OHFNRH78
         0MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782145235; x=1782750035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2s41L5jEoLolC/wFtH4H+ngMP+cqu+AY2cetSGdFzI=;
        b=sGDxS1NtpLcIwOicFtdc8YQ+9ePn3+1SFeSDxW8p/IQnyffyZ5RTgEflKMcKIQSW1x
         HhlLnCi6jh9+0Kmg+ex1H8ohxKByjWjGSjWPRlkDudcz/bxnhIPQAl76awboU1f3/7Ki
         JsmNuaL3oYJpYnKz5fEQSC/qONfpQ5D5rQPxM1DJ5xK7NgezBZwlK8n8ENJGtTAdxmYS
         QqxnEtRWnd5tQeLq2PhroG41KCFTmO+Nu58Do0RSjV3N+rAcetlNCgp0h3bZ4JmjxKse
         7k5JVj3QXyYHcCIEdRrpVqnR8i7bJQ07VSJvUhwAuduU2cCUOTMTivZrwNnTxcrRUil5
         Ygow==
X-Gm-Message-State: AOJu0YzHRcL7P543+9bjpIDm6WrWiBWLt40bPwlgwWbA8gOfBFoV/03I
	JBltb+YPVxA5BOmnRl+WfXYsJCplQjOy9eXkBaL5K0QJA+aANASjuJeDw/Vu7cX2K/TIbXCQ3sn
	yCnKXfyYYQOW57Z6QTsSS0pOXCq09eICzifpFY9iw
X-Gm-Gg: AfdE7cnIU9BNs7wq6KkqcuYn7ZxR1Z2dLUHq9RzTUa0dMAFyfI04ujyMIdQI+U5oR3r
	vEzQGDAVP9zJh5lp5oeN8Caju9k2MNkmqdecg/iVLwZogOzV8BfvT7dPyDFvU8MRJ/+XLm+v62h
	NVrWid/fjj94UEn23njinEXoNRUDKGk6rd6H/klyfjZQuXJexliqUJENUj173HjjsnfClcZiN28
	3l2K63K9iFOpHwfNRJ7Keol6MNoIqxkz6aV++jj3RcOKmq4ldV5ugNQndpgUgvtdXHfKphjFXOJ
	qxhwGSSV/9bMuXAxeBl7Ca10Z+n2a/2qUTIqmbg1voE5SdwUsWPcfT2d34xYEEXSnc38BolZQny
	LVKORgjpxEMLwUH7P/jMvbeYDUIhwZHThGQOVeoE=
X-Received: by 2002:a05:7022:f689:b0:12d:b993:c68f with SMTP id
 a92af1059eb24-139a4eb3fe3mr7372238c88.4.1782145234469; Mon, 22 Jun 2026
 09:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782067871.git.littlesmilingcloud@gmail.com>
In-Reply-To: <cover.1782067871.git.littlesmilingcloud@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Jun 2026 09:20:22 -0700
X-Gm-Features: AVVi8CefNqoZIwMgiAqTs65Jmu1vMLZc99AH-rRVQEeoV0pk5hWF6Qn8wG3L51o
Message-ID: <CAAVpQUAQR3SNTpCuTvEMnMsOmyJnOyWWoOWS6uARyd==ZfDung@mail.gmail.com>
Subject: Re: [PATCH net-next RESEND v3 0/2] udp: fix FOU/GUE over multicast
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, davem@davemloft.net, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:littlesmilingcloud@gmail.com,m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301165-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3BD46B119F

On Sun, Jun 21, 2026 at 12:04=E2=80=AFPM Anton Danilov
<littlesmilingcloud@gmail.com> wrote:
>
> This is a resend of the v3 series originally posted on 2026-05-05,
> which did not receive review feedback during the previous net-next
> window.

Probably due to RFC, which means it is not official yet, and the series
is also dropped from patchwork.


> No changes since v3; rebased cleanly on current net-next
> (after the net-next-7.2 merge).

net-next is closed, please repost next Monday, following the process doc:

https://docs.kernel.org/7.0/process/maintainer-netdev.html#resending-after-=
review
---8<---
The new version of patches should be posted as a separate thread,
not as a reply to the previous posting.
---8<---


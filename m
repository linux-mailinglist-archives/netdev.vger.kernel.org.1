Return-Path: <netdev+bounces-301964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id boT2IxIwPWq9yggAu9opvQ
	(envelope-from <netdev+bounces-301964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:41:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C13566C6358
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:41:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=TtPPUcYM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301964-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301964-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5DCE301C5F8
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 13:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AA73314C3;
	Thu, 25 Jun 2026 13:41:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44224149C6F
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 13:41:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394861; cv=pass; b=AfYEUhc50slbdvdOcA3dwDg0qwTSosdZkw5O5uDoSU9rlDYtv2M9Lyc7gG/lRG2wQ/+h8syAt4vGA24bufnmW1eQp7RZY0O9g8wJ87DxUjz80HaeLFEnnaODpQ+cgvIEFDWVQZxH1sv6GVzZbjSbEBcpyuR1GohIiY7cHxDfwdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394861; c=relaxed/simple;
	bh=xtW7rMNS6favmC/NX2OBC+xBddY+0MfAd4t+qaOXIHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZ6UnhC8bvU2oLWQGPRNabx1o0qi7attdv8OIhiOhiLvvNYGfnTKGvE3skFWIlUpbrHxSOsgNQRtyCsIHqUqUQkUL78nUTfK4xS+LXxANQXansg/iI22gO2Ed/Jix6pcQfIZmObnvIePvcBW1LHDY+yJrPnjH7pIbW8qaOjia3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtPPUcYM; arc=pass smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ad5e719157so2423431e87.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 06:41:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782394858; cv=none;
        d=google.com; s=arc-20260327;
        b=I6XvsHCF0bTzPfnTAzbJ0+H5pGGt7fjZeo0fDihUI0BnizjC2QX/Jsu53tjG/Chwpa
         8/yxyPz/6rgAmaXYM+9J4JlqX9mNhp7gqMavtcjFiPSwmaLpRLyC84szSKnnzMi0+tE3
         8K5+hdPkPF+peBT51stIm9Cd3YSLJOzrsQRqVSnCDIfLS4R60SpxmYoF5L8y18jIpses
         RC90UI04WB+umMjl81F8l/GRAYTfVEsnE9se3ua1neR9Y8QG/S/cWr4fp0aAnOqJ/yeY
         tJqdSPX81FUbtWwoonc19cfjind5wh1T08JV/Pjp4FfckJUU2EG7eAbpan4aLBG+WdJd
         Dy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xtW7rMNS6favmC/NX2OBC+xBddY+0MfAd4t+qaOXIHY=;
        fh=q1r88RbeZU5IhIu7xSLyyrEf0/MOLQlGDoKzK61hiIY=;
        b=KU9ypH0NxetNfRdfd/6fn8SoXunR2/84idEkzyr+ZESmOdV0mlE0Z5WFMvI/KmUr5z
         YPBFlOqEkCpuItIDt/NxxhnRPyiqP5SizxE9ACo3ZAbyVPJYlt6XLPBVBm2/CveUZovQ
         LAiA6AZZhdP/8kf6TQgLWfgtybQyEXayC9m0yVpLbvS5scWcdzhUP/JedpHNbAymZH7w
         UTzyvtyGLze1B0sn2lhN8hldax0t9h5FBOWTicqPwCbm07xlMG+kpjEEYncuEVCqGKIB
         6lamfJ+2CTfGuPzQgPH3ehBmDMb0RE3Tmo+Az7ayaJnRU5jwHeqgxZjB1+8a+jZu7yBi
         tDlA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782394858; x=1782999658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtW7rMNS6favmC/NX2OBC+xBddY+0MfAd4t+qaOXIHY=;
        b=TtPPUcYMkgIFrkFeGzRM12qnW79hJ7odO6ZrP8q9g03ch89UGYLCDgp0ae7YCCUKGI
         PJgqU1OLLblp08jO3BhmXvjPWOE/+Gu2G3ZpjuiFQtI0lRTofBiAzX+50fpgLlWZLNBw
         defRHxiDfXbik8JVfXgJpNazqW/vt5yOUzi/mi93mp8yKUYS9pG9z5YXFFbF1iRr406j
         +2xUNNTpv768yLMeEKPY9MWRZxfVIfaDNydLdixwXU9GE/NGuaDJTNNJzoeJPQDnR7ei
         AJ3ZyVTDxJk6Lo6Vr8afIRZB2IB+HNFjrlpt1rKEKMQey4ZBB3S7E409AtW/f+LU9mew
         0z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782394858; x=1782999658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xtW7rMNS6favmC/NX2OBC+xBddY+0MfAd4t+qaOXIHY=;
        b=roAhfxznMz9/qKCogCLIk7nhnlnrOPdlN7w4oOdgbBEaYF3wqpvFjRGbaZVVe8vJw7
         PQUMMKZgxKtJGbD8IAHWYBOKzBu48UWMbV4WeDH9A+FOubmxB4bceVt+D68ugWdWXJcG
         dlCSyOtq+TKsc26yJsSWljE5ENeM4V0/h34oS5fPv5x10L0lmuOHioSvlCq+jb21UcAe
         ERr+pE18suoqxDsCnFUZm6L1tLQ82yCbhsra/OhPNMNsWY3E5by65bqt4ewTwh5IQxvO
         nt1gREptNHjvcYgcfKayg1E8kStdvEIWGzJz1csUTj3+X/VIxlbWe7ngT4zUFFUqTrfs
         r+Sg==
X-Gm-Message-State: AOJu0Yz6Lv1HA2Kp7jc2i9iaxTyZHzufHI5JKVJhTiCWSbpvPMjSpkd2
	lFxPxB2RDR4OhAstB9vYXRfzdHcRY2WTfCLg7G1cLr4WQyP7L+zzs5B2rRGTbavaXvz+88aLrA3
	hWWgX6CKxaoJoX8y0QvyDOHeq0tjUclU=
X-Gm-Gg: AfdE7cmgzLukHH9N+WWgVFYwFQ7g4p+qI6sdIKl9AcWbNTBUQHM3kXsNs43rdxY68VW
	RLUzSkSzjRcWsc/v7eV1Iww5VIrWpx6756xJRNHm3rZ3VtjCSNXlj1fnyvDvkVhufbSI8c2ubs+
	uORjd5vfDtUkbEd0jpRfV8RAbdKFC5N12eHMiRGoHJAcBNuqllNKnsiBGqGSvxn1ZtjvUuNHqVO
	ZF4Qa2P30uWNb+m+vgD6P6vWzuhjyQmEa33e9qCBSAqOre2lyKO/ycV5/5TYpA7Al+rfw+aVKzp
	Vg0GSN+nFkn9w1octSk4UYLdF3GU8f+fxgLkQ23DqoT6VQ9en5ygxFkHuA26UVsrBNzZuF+DMj+
	r6kkA/zcuWA==
X-Received: by 2002:a05:6512:6093:b0:5ae:a4a0:721d with SMTP id
 2adb3069b0e04-5aea4a0741dmr400155e87.31.1782394858196; Thu, 25 Jun 2026
 06:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625115215.1101928-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260625115215.1101928-1-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 25 Jun 2026 21:40:20 +0800
X-Gm-Features: AVVi8CfDcn_mtY7ztHvI5zRHxmjaEiDfgNbZB4FX4ThmzS7jnZieZ31ASCK2EZM
Message-ID: <CAL+tcoBgur5sAoUWyGsd2rhpC7Gcx3peh=sRKmkiN=9myNRMYQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] selftests/xsk: Preserve UMEM view in
 BIDIRECTIONAL test
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	tushar.vyavahare@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tushar.vyavahare@intel.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301964-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C13566C6358

On Thu, Jun 25, 2026 at 7:52=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> The UMEM state refactor made __send_pkts() use xsk->umem for Tx
> address generation. At the same time, the shared-UMEM Tx setup copies the
> Rx UMEM state into a Tx-local state object and resets base_addr and
> next_buffer before configuring the Tx socket.
>
> Passing that Tx-local object to xsk_configure() makes xsk->umem point to
> the zero-based Tx allocator state. This breaks the BIDIRECTIONAL test onc=
e
> the roles are switched: the same socket is then used for Rx validation, b=
ut
> received descriptors from the other logical UMEM half are checked against
> base_addr =3D=3D 0. With the new UMEM bounds check, a valid address such =
as
> base_addr + XDP_PACKET_HEADROOM is rejected as being outside the UMEM
> window.
>
> Keep xsk->umem as the shared/Rx UMEM view used for socket configuration
> and Rx validation. Use the ifobject-local UMEM copy only for Tx descripto=
r
> address generation, preserving the BIDIRECTIONAL test's intent of using
> the proper logical UMEM half after the direction switch.
>
> Fixes: b17631032769 ("selftests/xsk: Move UMEM state from ifobject to xsk=
_socket_info")
> Reviewed-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> Tested-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Oh, you've already pushed a v2 patch, so again:

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!


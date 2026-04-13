Return-Path: <netdev+bounces-277959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILCCNER/3GkaSAkAu9opvQ
	(envelope-from <netdev+bounces-277959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:29:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8833E777E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 07:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C03A3005D2E
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 05:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3764A38422A;
	Mon, 13 Apr 2026 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iAEkf33f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC094D531
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058178; cv=pass; b=DCwtOjZ9zHRIUcfdv6Agyg1iNm8SuCMmYyHc/n9d0gtut/9jZOOKDnCS9iyvoG1/xFWa250UaFMTqV2rAKl6cFG03rmKTQFezaenvP+eDZmXeCny/XvlH9tMsyf/z2KoUyIMaSZOxyyOzglTq5C2puQTTFmjDEjlcdu3cMOO4pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058178; c=relaxed/simple;
	bh=xXhsk5f/jnU+/3Wa14pFOKL9cEZ4W4D46khadCmMW8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUxWW1S5ZP2XvUitKonBo/zfIFnmanCskYHFlZylmxor061jm9A6b0TM60rhd8qHAZQtGzeSSHDFJ5MHGYV2GBD/RnvDMOAGnIrecIWiOe/OGHCSiRsUYCFo/9Ebqb2fEwRkj0z27C0k1kiTDUAM1q6BofMlXWWRaiHpKVnO6aQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iAEkf33f; arc=pass smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso2106424a91.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 22:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776058176; x=1776662976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHFAPYVOLGe228Gcx3FtSVkNvwSX1cYHKiyZVY9uWWU=;
        b=C6Dti8zsz7tE6DjobUjEDOZlsCnDS56+KWCEyPVvnHYYsBslT7YI9IxrM+LhsJ4Fs7
         vkzH+KmejQLIjLoVF2n1vVtrW67Xj52Kt3xNv+74lsEkDok4QDPM8EmnuA7LXsa0UEUu
         m3xOqaQRO389+w+e3KpY6k/VcWCQYhwrd83+t6d19nbjqflz2y269T7ddgkrXLOfxUGR
         ujsE48OqjQT7QI7c3D1X4JKYJTNAPx67KOJrP+z/2FVaPkD/tmU6O7Pt2sbhzflt+SvI
         xUsuW/LScnLm9yTdNWbIWWIsbW9L4sh9b7s20hIxW5V9abRm/fkvSBYZXqkAntrn6e9b
         WTMQ==
X-Gm-Message-State: AOJu0YzZngrB5lPQZRDC5k63AWIt5/jbT5ivde7keqAbviuT4/sPiiHw
	6pK27ywtzANAixIwfHQXom8ToEJtlJGb8F8p61PLhTevFBdHsr1ZS6lA7CpPpMJTAt/5tg5uXVn
	W7/sKypd+ugTqy+FgFPu8g1oFhEowpPsvraFouTRSIS0WCtLCkd9GqDFYnkFNqMK1lzFSl4CpsC
	3jkraP3xWgjR8R63pRrfEUxUd9NXfBXsRkQCTnkB5IQ0AIqtOG+VkxonKMyIw8LHq39d6J6TUcs
	RuzgxCVyw==
X-Gm-Gg: AeBDievAHquLxWdIhZZvK51LVx7ATpYWuD5SzxKWq5Ru6aJad/3ClEa+WOkUyb72x1K
	V9Rkcy9v0/TJ/jTcGE6x2dQnZJHGNyCahk5qNOklECfyZRHNzY22d4kKq6Qn/BAOfs5osBnOCVV
	stXqaBp6YskysAeIUlKDc7gp30sgTFp047TpGkeZrTof5CpZf/dSqR5EuDfJyvlt/nmxSh1TGlP
	2J28z+cjOW4vupn6ny9PMAGLljE87ifDhd4e1Qunnx5B9sZr8emuKuqT/bX07YDcXwxD3Myodlo
	IgKDE9RHFa3AWWnIXlgj4dbEs5+S+JGWyw+45Z8+9EPi9WthF8zDk9Fh8sRPvJGt8ah3fbnyQT4
	cuokQlJC4rlJah5vMBn7/sqUM4aNPgxOUV5H6RxEAn5cFy1NiKOxw8A4fv+nYgCuKhbdC7GLxNx
	71b2ocZitUv0w/NZME1uAEVp4BVx2xnvNt7ceeboHXgEefF01vwjjs7Mo=
X-Received: by 2002:a17:90b:1e0c:b0:35b:e5ba:c0c8 with SMTP id 98e67ed59e1d1-35e4289ecc9mr11714089a91.28.1776058176067;
        Sun, 12 Apr 2026 22:29:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35eec32f6d8sm413980a91.2.2026.04.12.22.29.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Apr 2026 22:29:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-60521f54387so1788393137.1
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 22:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776058175; cv=none;
        d=google.com; s=arc-20240605;
        b=QTzLqoEez6H2iWhrptElLucToViQasDOTM1RIOaTbC1XLcFJFrQz/VI2QZ26icYLVz
         8jmfbEHXtKYGiAgLSWoCzI0MB6fIEb/z0RnvgCGczRwzK9bmQBv271Yik090s4wlfyaU
         bVFlaIPXONqtUrhp1gJDQJc2j/qbC8RYHkQpTgabl+p9oPErIQlJjw1osqc0LnJKDYr3
         AeMzkUhOTanF+ROO1YJI9+QS4gRf/VhLyRuODQm+3rDe6nkx4smtEa0SjoLlMcL9mmCZ
         y+P3cDGWMMZRSOGTaZsNgXgfV0MB+h/ZpjldFsjh9MFKFdfAlSnZiXFaja1DHcNHwHRm
         Vf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BHFAPYVOLGe228Gcx3FtSVkNvwSX1cYHKiyZVY9uWWU=;
        fh=XU+QMOLbi4B/udLt7049TMuKdOoviJdjDGYlBr6kM5c=;
        b=kD4wighLyv45F1X2nhH1rorqbAIQQmlzL48u/bVDsf0TKYhlh2dq8ltUQGeL/pdS3C
         yEZwDVvlyq3tgsBmnzn3njyM2c2d8bQtnB+8AgtKL1LjbQSHFpKruTC02vCKHiAc+xzO
         +qUrw0dt0L42rn6oQeePR12z0KSOrRYJR6IVcRtdxE70x7YqdfI8GHeNVVuLrrPaV7sq
         ncxSoBxo5riI1mtdoyiy6LyRQvfqOiLUIxjIhI4HZz/2ut5tVsy7gEChSldS7Ea7GezK
         IGlcP+CosicDaPs/pYOdq5/8VkDExLmvc9r3p09ut5i8yGPhABdiV2hhdZ4x+2WpVpiU
         u5cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776058175; x=1776662975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHFAPYVOLGe228Gcx3FtSVkNvwSX1cYHKiyZVY9uWWU=;
        b=iAEkf33fG7YQtMdvU5L51RVsODODYrDgeX69a6D/1i69Xb9JtFjILby4JB5aovjmAV
         T4jCptojMDOylhWzshJmxE6CpVhxtgKSBANGfI7co/DV1dZVvNnKT3pPoLqrtMX7sYkS
         NNX1blnsV1QRZ6Dr7w71cquTPaebxFF3HNJGI=
X-Received: by 2002:a05:6102:b15:b0:605:19ce:9cc7 with SMTP id ada2fe7eead31-60a0136cf09mr4126044137.28.1776058174777;
        Sun, 12 Apr 2026 22:29:34 -0700 (PDT)
X-Received: by 2002:a05:6102:b15:b0:605:19ce:9cc7 with SMTP id
 ada2fe7eead31-60a0136cf09mr4126036137.28.1776058174365; Sun, 12 Apr 2026
 22:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026041124-banshee-molecular-0f70@gregkh>
In-Reply-To: <2026041124-banshee-molecular-0f70@gregkh>
From: Vikas Gupta <vikas.gupta@broadcom.com>
Date: Mon, 13 Apr 2026 10:59:22 +0530
X-Gm-Features: AQROBzAhm7IgGFFUnK9903pQXEmxolRH39rbb-DfQ4Oqbb8ql1un1ASOcLTBbhg
Message-ID: <CAHLZf_smM_=1sGvWE+no02qKSegXWCsGrFW6daXR1PvnY842rA@mail.gmail.com>
Subject: Re: [PATCH net] bnge: return after auxiliary_device_uninit() in error path
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-277959-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: 2C8833E777E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 4:15=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When auxiliary_device_add() fails, the error block calls
> auxiliary_device_uninit() but does not return.  The uninit drops the
> last reference and synchronously runs bnge_aux_dev_release(), which sets
> bd->auxr_dev =3D NULL and frees the underlying object.  The subsequent
> bd->auxr_dev->net =3D bd->netdev then dereferences NULL, which is not a
> good thing to have happen when trying to clean up from an error.
>
> Add the missing return, as the auxiliary bus documentation states is a
> requirement (seems that LLM tools read documentation better than humans
> do...)
>
> Cc: Vikas Gupta <vikas.gupta@broadcom.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Fixes: 8ac050ec3b1c ("bng_en: Add RoCE aux device support")
> Cc: stable <stable@kernel.org>
> Assisted-by: gregkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

 Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>

> ---
>  drivers/net/ethernet/broadcom/bnge/bnge_auxr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c b/drivers/net=
/ethernet/broadcom/bnge/bnge_auxr.c
> index b942076762ef..67e93e17d4d9 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
> @@ -194,6 +194,7 @@ void bnge_rdma_aux_device_add(struct bnge_dev *bd)
>                 dev_warn(bd->dev, "Failed to add auxiliary device for ROC=
E\n");
>                 auxiliary_device_uninit(aux_dev);
>                 bd->flags &=3D ~BNGE_EN_ROCE;
> +               return;
>         }
>
>         bd->auxr_dev->net =3D bd->netdev;
> --
> 2.53.0
>


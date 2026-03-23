Return-Path: <netdev+bounces-270451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGwRNLoRwWk7QQQAu9opvQ
	(envelope-from <netdev+bounces-270451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:11:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE042EFC2F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADF00303B7EB
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F3E388385;
	Mon, 23 Mar 2026 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gQ9CGX2V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8037BE66
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774260284; cv=pass; b=NBJbOybjDJVwSwqQ3M5+Sg7TWVW9S4i7Aey9EGRQrx0Ifhf1NzE3yhgjYeUAn0tj2iSj84cuRn9z6uk6oWkgpm0rkLmZlKHmn9eQRyxZeDiBvAR3AGpQrhXDKzAsZ/ogmHN13jxHJ3pHBqP3SOE4d+ClS3QRcUDlyh4ZfpwlIPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774260284; c=relaxed/simple;
	bh=5of77S05lcuEmJQQlrpWYoXG3JNddsIo0qsg3xV3SVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwTIII5jfm8+d+T03DsUI98HfRyynCZ+CtpVhfCY0AABmRmCWIHYTdDnlVsC5ffHUQ/+V9UQ9+R8AKBV/8a4c3HvJtBwlVNd7QZtSMmwDOcgyKNpFCAmITHFsB8ADdGy2l5iHzo+VwT39ahKr2Wh8+wKggmH/oDqEJI2zjE1y10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gQ9CGX2V; arc=pass smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2b06c43e6a7so13692765ad.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 03:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774260282; x=1774865082;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbhYQLyVlpwciqWsitvf/PAU+Xv955RtgpQqOx++CAo=;
        b=F1IBE2xQ/AswyVx6uW9/B8/2rUVHzFZ2Lwc/MYZBAO116FuSMi8wfoKDG5Pvvnz70v
         LkuuAATOVeoCxam0sa5PMKwM0zU/O/RLXRWVV7fzBifs+IizKrH5mBhd4LY2vtbCZMcP
         B9PWV9S0UAtiyq4H5m50ut/b8i4+3J+1d7ec/CElWBJN3u6f7bTaajofJD0NsSvDia0Q
         vqiQyJnTRsD+IzIR/GxN2+qwziMbvml+llXlYj/YdYX4QSHNu5Ebll/DFZIA4w34i4xc
         3bUnOz02BX2SrJ3MQqX0sOUC2TDgbaxU0AnZgLHSwejMoRf9bddxWMT7QYENlSGSfuzS
         bvWw==
X-Forwarded-Encrypted: i=2; AJvYcCUjp5kFeiHrXKyX/mVcAs3bWjv1uzgQ8d2RK7mlvxeTee5wqvlAJZRQt/AFVASYfSD9VifNtHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2GaTqbDiZWDz4sCtE0TbGgAhEZQWovjpgte9uYU4p+HGCDtj
	n67VNMJvkrLcTWk4cddMNxM1G2Vpzzunsj2d7S08RoTG3fSHKoHhCQ/bmRO8QBimlVBsxpi4rIX
	kMBNNXnX4iXBtzJH9vK5Un30nXW/pFeIuJtbP99UkgbbzoCX+SBh6A4WRx/b5UqqZieByBn80Tn
	2YPUIdFOsXOsPiQkVki5lCmnShowcgNc6K/pEC9ExiNhs4KeISHnldPTb1oWX96krr0T6YCADQb
	VBJvRIwJfw=
X-Gm-Gg: ATEYQzz9L2/CZ2P1HCOSFVT8upJ8HA3J46roQvuq5l8weWste8fKcSI+yyBlAF6Zr6r
	wMOOdTvg4/7M/ElF2DaJFnW8aunkAvDIflkE5suYXURN8jlQ8aPo9jA9TZn/lp222zKcUv3/w2Z
	MQcpU/qKusWHrXH7M5HDFhCbe1hr9o12Dyyfnpw33GITdaEX2AfzlLMnSURZ2KzRnVoIM1pfdgA
	ang2fjzFToHVbcFxhjL+JfFLgWwyQ6s8jpVZyguTlAousj1FJF3AOOaVsTv9Py+4nXRlMOLWSDw
	xM0Igxci/YNi89e1keekBML/hRuBlyJ3bZGo143nRXzNWYw4fnPKu9SLoiYGta4/CIuh8MjViCL
	g5xA+VpHcawgPUslmkW6XnKim0H3NKZ0gxoefHpqRE7ZPeJEvgnPyoRT1FneG7TmuEMZIqAYQGM
	zRZmc/gWoL+1NE6qmNSHbYXNQuVycEbXgquFHLSVZfodzIdx27emEFnn4lxZE=
X-Received: by 2002:a17:903:94f:b0:2ae:c862:3a2 with SMTP id d9443c01a7336-2b082733d15mr101704185ad.17.1774260281920;
        Mon, 23 Mar 2026 03:04:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b0835f5aa0sm13185375ad.36.2026.03.23.03.04.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2026 03:04:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b8ff07df5e4so312325266b.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 03:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774260280; cv=none;
        d=google.com; s=arc-20240605;
        b=e17BNQCCoNVryaWCc1cmQPtSbo6Zs7CZS0ALVn6EQK0fYYaocSoQvD8T6N9RyizVUU
         az2f916CJrvAd2Kl8QdDz0Ih/LkgB6dqZhO2r6bhxZ4WUZ44FszC+aRrV+E3e/f0A302
         Kf7YHk8rTNFzznPRm7Ngj52KqDROUgR/5l4GQroFCk/3RDqSDI1iz8Q6wq0yPN8EfnSq
         6IJaZXIpqXKZkonaouZKyO6Ybeh6xvdbpx3vmSBIas2ZvWFVcZFccobuSmN7Baa48pb1
         PdzkguyKKEtcvYYh8kjW571GAArvkPq+WAqJs93TrmwXrFX4oE7oYlkU2zU+O6dZKjEU
         KdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xbhYQLyVlpwciqWsitvf/PAU+Xv955RtgpQqOx++CAo=;
        fh=PXGTyhJkCF4ihmIjhl/EDM28lEnFQ7hiwwAJavLmsRk=;
        b=iUNwo0d845pnJiRgj9z+P/mHnKulXmPd6SmHTGvCorgpRz676IvnWB3RdKpGvNzVfX
         RdM7hBTblySd35sxF5JDgqVxVbQGjx4DxdUJM9jPbrNpacAAyvbAoIXfMGz1/L4Rk2Lk
         SH56J2BUj35jLuzP+eJja0pu5O9E35tt7sVBuGXTGuj81SyTFnuMoOmNz6P0ZhDjR8dQ
         +63tlOba9N3SGwMP19uEaY7IXCbk3rDduqxnSw83E2G/HOmaDNOB9y/RpsAJUxeL6+ON
         6mNgrVRYA8SDGMUvI58WtUA/K9GZ9kvHPBdqeRTBYYD7v0+1LcE0zfCNcCXErGVFvA0B
         BxYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774260280; x=1774865080; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xbhYQLyVlpwciqWsitvf/PAU+Xv955RtgpQqOx++CAo=;
        b=gQ9CGX2VdmjgWYhMIlXQDTgwPLFBE8n66a10klU3JvAKqWiGZXRkX1BkYtSQ08mN+c
         xV1j9UsPr550VBiW6+H/Xl9I/rPKjTRxwWxd9R5TDP8Q1176xwIL2wTwQSQGcfU8mQDZ
         o1oRWcgmyb7LTwV29ZltSDJ6g4V7WWB7+6ISc=
X-Forwarded-Encrypted: i=1; AJvYcCU7HVacTa8LrfdGcvA/TeT/URfqVhmuM9nFZmTESAbxqGL1T+sq6huPyxMTtmLGDdzGqiBV8tA=@vger.kernel.org
X-Received: by 2002:a17:906:5a87:b0:b88:6309:c300 with SMTP id a640c23a62f3a-b982f3dfbcdmr606525266b.39.1774260279502;
        Mon, 23 Mar 2026 03:04:39 -0700 (PDT)
X-Received: by 2002:a17:906:5a87:b0:b88:6309:c300 with SMTP id
 a640c23a62f3a-b982f3dfbcdmr606522966b.39.1774260278937; Mon, 23 Mar 2026
 03:04:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323080845.40044-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260323080845.40044-1-pengpeng@iscas.ac.cn>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 23 Mar 2026 15:34:24 +0530
X-Gm-Features: AQROBzByuwXMwMuADSxdXTJrvzfLJxEFYSLSkDxP5zk8wYrBIQF1qP2T7v2JKuA
Message-ID: <CALs4sv0PP6PERcfdBYRqnxEwYKCSq7zPD2_SaAd1Xk+_T9PE3Q@mail.gmail.com>
Subject: Re: [PATCH v2] bnxt_en: validate firmware backing store types
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000baab57064dae2965"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270451-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pavan.chebbi@broadcom.com,netdev@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,broadcom.com:dkim,iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BE042EFC2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000baab57064dae2965
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 1:39=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> bnxt_hwrm_func_backing_store_qcaps_v2() trusts resp->type from the
> firmware response and stores it in ctxm->type. That value is later used
> to index fixed backing-store metadata arrays such as ctx_arr[] and
> bnxt_bstore_to_trace[] without a local range check.
>
> Validate the returned type before storing it and abort the query when
> firmware reports a type outside BNXT_CTX_V2_MAX. This keeps the fix at
> the point where the untrusted value enters driver state.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> v2:
> - add commit message context and fix rationale
> - no code changes

Patch should be marked "net" and should have 'fixes'.
You must wait at least 24 hours before sending a new revision of the patch.

>
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 0751c0e4581a..d0446f851d66 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -8692,6 +8692,7 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(st=
ruct bnxt *bp)
>                 u8 init_val, init_off, i;
>                 u32 max_entries;
>                 u16 entry_size;
> +               u16 resp_type;
>                 __le32 *p;
>                 u32 flags;
>
> @@ -8715,7 +8716,15 @@ static int bnxt_hwrm_func_backing_store_qcaps_v2(s=
truct bnxt *bp)
>                         else
>                                 continue;
>                 }
> -               ctxm->type =3D le16_to_cpu(resp->type);
> +               resp_type =3D le16_to_cpu(resp->type);

What's the logic behind having additional 'resp_type' ?

> +               if (resp_type >=3D BNXT_CTX_V2_MAX) {
> +                       netdev_warn(bp->dev,
> +                                   "invalid backing store type %u return=
ed by firmware\n",
> +                                   resp_type);
> +                       rc =3D -EINVAL;
> +                       goto ctx_done;
> +               }
> +               ctxm->type =3D resp_type;
>                 ctxm->entry_size =3D entry_size;
>                 ctxm->flags =3D flags;
>                 ctxm->instance_bmap =3D le32_to_cpu(resp->instance_bit_ma=
p);
> --
> 2.50.1 (Apple Git-155)
>

--000000000000baab57064dae2965
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA3NsKn
JSuPT0wGYN/j1iyzlWXxpIbIbK7hvWs67bX5ejAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMjMxMDA0NDBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAIlgmCpB/SQYogaEMDCrKjcx844UmHvc6M0EMranwj
/PT2IWw/B7RNcIO51sDlPxM5LeeaY4XJU+Wwqr3yGS/k1R8r7EIui05cWFRl8I6/WImuC5ML1uY2
OghpVTu7sW7Mz3p1xFTBD7X9XupCab6LzTl5qz5V8vjnRXL/gZkf7zUKW+kFHZLA9snteHUwAGpZ
OjJ9xy5wYbTyVTQSW7EcbwPEPRK2q47LeSSICOGwzARRVebUJySowrvRBd3a+e+Oul1I8FxjUhzd
uRuX1ryeUQNWg8LsU13FQqhLFtiSbd/FNPB1X+pynaK9w9SHz+twFrM2fq1cZuzotJOnPlC+
--000000000000baab57064dae2965--


Return-Path: <netdev+bounces-40590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD847C7C5A
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 05:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7201C20A68
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 03:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C917C1;
	Fri, 13 Oct 2023 03:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Yxgd7LHA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A310F8
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 03:53:48 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EEABB
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 20:53:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so3045845a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 20:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697169225; x=1697774025; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqHOYD9skbBtnVEnMs5HzOJN1iA7iybXu4wpvFZqBrA=;
        b=Yxgd7LHAfg9md22AlwFFc90/jEjdhvV+hLUi0QXpXclUhEVT5ySLsWWG6YUMS/zRtk
         f5s3Ahac0exWC7hb2rmGd8Hh8U7NCXXZQf2GJ7nh/5E8F4I6q/BLZBOD7ffEU7W4cC8I
         MSwLDFa6c46hmiW9qCVokGjxhnO9uh/msJALE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697169225; x=1697774025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqHOYD9skbBtnVEnMs5HzOJN1iA7iybXu4wpvFZqBrA=;
        b=UEcGm29LFbSdaJTnjzJVuhdnBlioXXJgGlRAJMQdDr/MrfbTPP3QqxYxnbiQ3XEcn4
         tWtm7U4cPJgm7/1eP7G539tly6PmhruhZtVeEZHwclqlKeUjd24fTtcmlUlLaYCplop0
         12Cld20+vliBuE4kNwDUQ3ekAd6omohJsircx/CwjILhmKeO/mi7vyYRp75kcE1KOKrZ
         Xpjftv6GYKQZmB0L8uxQ7BcQPjpbMgwFaM6JV/cYOk4d7xHySK/HjGvSwUT2/N/dxG5N
         i/fnhl6d/NDlFp1ecXc1Zt/3fO+PYZiDNSD0kaM8oTQW2K2AKOKDfdOCtSXAgIZew7+v
         JfFA==
X-Gm-Message-State: AOJu0Yz4+/PY7MtKXbFlDkrkLmqR+6I83qUsTj7eXShK6a4H/nyAqxH5
	Kt9J1UtsxOaxB7ZbY128RjyZb41R4HmA76ouyuKA8A==
X-Google-Smtp-Source: AGHT+IFqxum+jZ6q0sQYbGxOSaEI+lF/Rmb0CqrSKf3J7aHUbYVPz6bNV3LBKMrAKcXjVymeoQ5sd4maT/KJv1Ns7m0=
X-Received: by 2002:aa7:c998:0:b0:530:a226:1f25 with SMTP id
 c24-20020aa7c998000000b00530a2261f25mr20878346edt.17.1697169225435; Thu, 12
 Oct 2023 20:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012224101.950208-1-kuba@kernel.org>
In-Reply-To: <20231012224101.950208-1-kuba@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 12 Oct 2023 20:53:33 -0700
Message-ID: <CACKFLinuMQ-0riznftx=dhWVnw76D=ek3YNFjbsBJeCjrNir7w@mail.gmail.com>
Subject: Re: [PATCH net-next] eth: bnxt: fix backward compatibility with older devices
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d52d3c06079100fa"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--000000000000d52d3c06079100fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 3:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Recent FW interface update bumped the size of struct hwrm_func_cfg_input
> above 128B which is the max some devices support.
>
> Probe on Stratus (BCM957452) with FW 20.8.3.11 fails with:
>
>    bnxt_en ...: Unable to reserve tx rings
>    bnxt_en ...: 2nd rings reservation failed.
>    bnxt_en ...: Not enough rings available.
>
> Once probe is fixed other error pop up:
>
>    bnxt_en ...: Failed to set async event completion ring.

Thanks for catching this.  We need to do more compatibility testing
with older firmware.

>
> This is because __hwrm_send() rejects requests larger than
> bp->hwrm_max_ext_req_len with -E2BIG. Since the driver doesn't
> actually access any of the new fields, yet, trim the length.
> It should be safe.
>
> Similar workaround exists for backing_store_cfg_input,
> although that one mins() to a constant of 256?!

Because the backing store cfg command is supported by relatively newer
firmware that will accept 256 bytes at least.

The HWRM_FUNC_CFG is used quite a bit in bnxt_sriov.c and also in
bnxt_devlink.c.  I think we should apply the same treatment to all of
them.

Thanks.

>
> To make debugging easier in the future add a warning
> for oversized requests.
>
> Fixes: 754fbf604ff6 ("bnxt_en: Update firmware interface to 1.10.2.171")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: michael.chan@broadcom.com
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 +++++++++++++++----
>  .../net/ethernet/broadcom/bnxt/bnxt_hwrm.c    |  2 ++
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 5c2afcd5ce80..10dc680f022e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -5855,6 +5855,19 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *b=
p,
>         return rc;
>  }
>
> +/* Older devices can only support req length of 128.
> + * Requests which don't need fields starting at num_quic_tx_key_ctxs
> + * can use this helper to avoid getting -E2BIG.
> + */
> +static int bnxt_hwrm_func_cfg_short_req_init(struct bnxt *bp,
> +                                            struct hwrm_func_cfg_input *=
*req)
> +{
> +       u32 req_len;
> +
> +       req_len =3D min_t(u32, sizeof(**req), bp->hwrm_max_ext_req_len);
> +       return __hwrm_req_init(bp, (void **)req, HWRM_FUNC_CFG, req_len);
> +}
> +
>  static int bnxt_hwrm_set_async_event_cr(struct bnxt *bp, int idx)
>  {
>         int rc;
> @@ -5862,7 +5875,7 @@ static int bnxt_hwrm_set_async_event_cr(struct bnxt=
 *bp, int idx)
>         if (BNXT_PF(bp)) {
>                 struct hwrm_func_cfg_input *req;
>
> -               rc =3D hwrm_req_init(bp, req, HWRM_FUNC_CFG);
> +               rc =3D bnxt_hwrm_func_cfg_short_req_init(bp, &req);
>                 if (rc)
>                         return rc;
>
> @@ -6273,7 +6286,7 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, int t=
x_rings, int rx_rings,
>         struct hwrm_func_cfg_input *req;
>         u32 enables =3D 0;
>
> -       if (hwrm_req_init(bp, req, HWRM_FUNC_CFG))
> +       if (bnxt_hwrm_func_cfg_short_req_init(bp, &req))
>                 return NULL;
>
>         req->fid =3D cpu_to_le16(0xffff);
> @@ -8618,7 +8631,7 @@ static int bnxt_hwrm_set_br_mode(struct bnxt *bp, u=
16 br_mode)
>         else
>                 return -EINVAL;
>
> -       rc =3D hwrm_req_init(bp, req, HWRM_FUNC_CFG);
> +       rc =3D bnxt_hwrm_func_cfg_short_req_init(bp, &req);
>         if (rc)
>                 return rc;
>
> @@ -8636,7 +8649,7 @@ static int bnxt_hwrm_set_cache_line_size(struct bnx=
t *bp, int size)
>         if (BNXT_VF(bp) || bp->hwrm_spec_code < 0x10803)
>                 return 0;
>
> -       rc =3D hwrm_req_init(bp, req, HWRM_FUNC_CFG);
> +       rc =3D bnxt_hwrm_func_cfg_short_req_init(bp, &req);
>         if (rc)
>                 return rc;
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net=
/ethernet/broadcom/bnxt/bnxt_hwrm.c
> index 132442f16fe6..1df3d56cc4b5 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
> @@ -485,6 +485,8 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_h=
wrm_ctx *ctx)
>
>         if (msg_len > BNXT_HWRM_MAX_REQ_LEN &&
>             msg_len > bp->hwrm_max_ext_req_len) {
> +               netdev_warn(bp->dev, "oversized hwrm request, req_type 0x=
%x",
> +                           req_type);
>                 rc =3D -E2BIG;
>                 goto exit;
>         }
> --
> 2.41.0
>

--000000000000d52d3c06079100fa
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFlb+5u8DpO1yRUFxQoKSKqRtswdRxb/
RKtbh2OyE+oKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAx
MzAzNTM0NVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB9hQ15dIm2o5ALaU3Ya6yzeLAmZdpbZYrpXkm30Em3UIVQRKJD
B0fauzsyP2NzNImSkxntmja+NuQZuUcQtIqVRSK5dtKrdTYcGlWo56RLTOkfjj3qT8Pw02H0wu4X
zJEQa+o+rBOAzERXdbvsY8jLwHaIJtWz1vJlUw2BwJ0tCk6WsO381fiUvT9ESDEsE1wbo8PVQiFP
H8wGkFaxk+JNCafLAgESw1BFywNujeVx0uimDu5TTRuXaTwQYfkbtI/FxUrD+ehnSHWlYDu/gIPV
6fRzhD6xQVmTWJUXkvucYXu0hBzuoU0udNjBbC0dzXImwQhdtAyahOwgtHYPQwfC
--000000000000d52d3c06079100fa--


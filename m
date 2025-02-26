Return-Path: <netdev+bounces-169721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24179A455EF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F453166EE2
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AC8269CE4;
	Wed, 26 Feb 2025 06:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AUP+km9N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC8192D63
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552384; cv=none; b=f2DD5i6besMMKP7STW2PtX2FdkRRoc0mIwrlA2nJlNrTNCCyGGQWg7Dxr9DwG5kSPaPr1ASwfXiA6DkusYXg2CL91V1Afg5Ik47zbabX1mtICBr49mr/H5UzsoNpH68fDqE8gQ6Db+Pm7mj8t0xjg8XKS4TEq330OUAvqsNocDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552384; c=relaxed/simple;
	bh=qx6DRwciSet8MSEi4GSvazHyJsMj3b0muMutFdblD4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mf+yJ+XzSGxzmLapRBUZC31wY6/+El+NZw6L9G3P54l3SGab8p2og34XF9JSzvFv78h+dNEc8B6x561+e0MM7fXIHTpWaUyIcw3ARbGbpYpjZMuulFedZ++4n4UCl95JwJmt5HWON788lFiaDZ4I1hgTe5wNpdQvkYrAeTN+HGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AUP+km9N; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-521c478d433so1518852e0c.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 22:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740552381; x=1741157181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1X9w+qCYlEJ4xC414hd0yH1qmTX8vWe1RIHTWbbVYDk=;
        b=AUP+km9Npm5FkZO72RISRrNnJk1vPCeFKhIn172gBe1c3rFjxeXylQOcKD/44N+qAX
         bXpsRhBbc6ehAlA/2x1upUS+V6Nw1Dyj26+TnoycrqI5quJWjg6fKOGgjJOEQIhpbZ74
         JjxFQc0pdsspSR05xMSsc9sPWbsv27e2vWXOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552381; x=1741157181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1X9w+qCYlEJ4xC414hd0yH1qmTX8vWe1RIHTWbbVYDk=;
        b=p8s+fXSyL9a6TnYkBFXdQtJh1Ll0CTBAHbTnwxktNDAyH+gaRaNXbynhiOLRtNV/Yt
         iBS9jEUuGjs8+jhO6bP08N0p6tj0EmH50e3/mAY/Ea9O+olZ54bWHLn+DOoqVyQT4viO
         9yf318offJh5khwpq66HtQu2HOe0fyJz7GehldtUizZZrDiG5wtCtbOGyGSaVPbaYSFj
         wgbodShMNsHF+AotT0D+dMNxyOgDQdPaK6LaqYpik3PE/pv9jReYDN+G2SwpWpWEx8nu
         NeGuMV5FD5U/oiJktZ95dixoW39WsF1qRhAeVqVM2+/1uaw0p/AMy75CZwJFQMyqz2dV
         7Kiw==
X-Forwarded-Encrypted: i=1; AJvYcCW1EqWLnlnsOtA1Za/MC6zFe4sKADMvXz5Byco3FmYU54BB9h/+5hL3wuRBN0Q8xeGiTF28xCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0TJSlnwQQlCCbh4wcWThBVQfwH+yxIT5QcpVIMFldBNTTQih
	rEXwMAta24Bt+I1T/+dseGfmWke9bBXh/vUbF2EWZp4veuQhcqM/Xd7ic0qO0zvOyXBeV8SGubv
	sxz5Kbg03z28JXBs227j2RdX/QTjm7rJFuO0d
X-Gm-Gg: ASbGnct3GgTo9LII72rCKd8JAZJKAb7p7VN1z82HPzstKZ2baCyWQOBTBiAB+X/fO0k
	xj77jURVIkPmz563EXvC9No6Mdzh2ChhsPDcDv9iRXcFPkDphdeDbd3oSHNMKpF2VU7Z/mYzVRR
	YsNB0FmdEL
X-Google-Smtp-Source: AGHT+IGawFobIeDMt3x9MDxRb6/XdEQ2KssqT1yLayf3KMKUKm5u0fICFURp8+THSdPrLWq2SgdYrFMhPrXqdQJ7m3c=
X-Received: by 2002:a05:6122:2a46:b0:520:51a4:b84f with SMTP id
 71dfb90a1353d-521ee2576acmr11506577e0c.4.1740552381455; Tue, 25 Feb 2025
 22:46:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226061837.1435731-1-ap420073@gmail.com> <20250226061837.1435731-4-ap420073@gmail.com>
In-Reply-To: <20250226061837.1435731-4-ap420073@gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Wed, 26 Feb 2025 12:16:10 +0530
X-Gm-Features: AQ5f1JoVLMUcOefYlMsUKI0PalIQOTV0265MShcUY3tkKaRCryUXj6Y5KcL-cWc
Message-ID: <CAOBf=muVJf+MLxUNN7jKRkKpU83SCgaYqvBiNdZDY=A0u-7f4g@mail.gmail.com>
Subject: Re: [PATCH net 3/3] eth: bnxt: do not use BNXT_VNIC_NTUPLE
 unconditionally in queue restart logic
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, gospo@broadcom.com, 
	dw@davidwei.uk, horms@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006d5406062f05ee3d"

--0000000000006d5406062f05ee3d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 11:49=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> When a queue is restarted, it sets MRU to 0 for stopping packet flow.
> MRU variable is a member of vnic_info[], the first vnic_info is default
> and the second is ntuple.
> Only when ntuple is enabled(ethtool -K eth0 ntuple on), vnic_info for
> ntuple is allocated in init logic.
> The bp->nr_vnics indicates how many vnic_info are allocated.
> However bnxt_queue_{start | stop}() accesses vnic_info[BNXT_VNIC_NTUPLE]
> regardless of ntuple state.
>
> Fixes: b9d2956e869c ("bnxt_en: stop packet flow during bnxt_queue_stop/st=
art")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 1f7042248ccc..29849bfeed14 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15635,7 +15635,7 @@ static int bnxt_queue_start(struct net_device *de=
v, void *qmem, int idx)
>         cpr =3D &rxr->bnapi->cp_ring;
>         cpr->sw_stats->rx.rx_resets++;
>
> -       for (i =3D 0; i <=3D BNXT_VNIC_NTUPLE; i++) {
> +       for (i =3D 0; i <=3D bp->nr_vnics; i++) {
>                 vnic =3D &bp->vnic_info[i];
>
>                 rc =3D bnxt_hwrm_vnic_set_rss_p5(bp, vnic, true);
> @@ -15663,7 +15663,7 @@ static int bnxt_queue_stop(struct net_device *dev=
, void *qmem, int idx)
>         struct bnxt_vnic_info *vnic;
>         int i;
>
> -       for (i =3D 0; i <=3D BNXT_VNIC_NTUPLE; i++) {
> +       for (i =3D 0; i <=3D bp->nr_vnics; i++) {
>                 vnic =3D &bp->vnic_info[i];
>                 vnic->mru =3D 0;
>                 bnxt_hwrm_vnic_update(bp, vnic,
> --
> 2.34.1
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
>

--0000000000006d5406062f05ee3d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
nSGLsSobByQoGh1GyLfFTXI7QOGn/6qvrJ7x9Oem5V7miUTD0wGAIozD7MCVoluf5Psa4Q2a5AFV
gROLty059Ex4oK55Op/0e3Aa/a8hZD/tPBT3WE70owdiCwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzb21uYXRoLmtvdHVyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUabMpSsFcjDNUWMvGf76o
yB7jBJUwDQYJKoZIhvcNAQELBQADggEBAJBDQpQ1TqY57vpQbwtXYP0N01q8J3tfNA/K2vOiNOpv
IufqZ5WKdKEtmT21nujCeuaCQ6SmpWqCUJVkLd+u/sHR62vCo8j2fb1pTkA7jeuCAuT9YMPRE86M
sUphsGDq2ylriQ7y5kvl728hZ0Oakm3xUCnZ9DYS/32sFGSZyrCGZipTBnjK4n5uLQ0yekSLACiD
R0zi4nzkbhwXqDbDaB+Duk52ec/Vj4xuc2uWu9rTmJNVjdk0qu9vh48xcd/BzrlmwY0crGTijAC/
r4x2/y9OfG0FyVmakU0qwDnZX982aa66tXnKNgae2k20WCDVMM5FPTrbMsQyz6Hrv3bg6qgxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx6wAr6NdQY0sTG
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHzsBWOcjQklDwzI+34WoTh9URGp
YZPQltE3aDzVrYKeMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDIyNjA2NDYyMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCyypw72+OtXbInYYBpQDnTDre22zTE1GpixV5XAsAuSSiV
gUtOKmTU+vOwzTueDuuG2AIH1nlsqLBgyTQqiJVPF/5cpxzjsw6nBvY0rPFsBMbvBMYFc9VqylcG
H8xKhdKBO0TaNm4bgip4F33GuTrUxURJtJ9aPA1cYR7czhssGzsGiJcvk8OA7OMLHZBD3luh1/N3
11y0ZjcrybNPPxsgqGGtttOeUnXpmZDHeYhtnik9X0UJB8MVPhzsBBgIhWw4ERoT38rI3X7enmvK
E837VVF9O9hmFO9dqG7iFb3oIbzq42Q6i4N8DsHG46BQfvsVsfbOPOkRj6Mg3kFWLqPK
--0000000000006d5406062f05ee3d--


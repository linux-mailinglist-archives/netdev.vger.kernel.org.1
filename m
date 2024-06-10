Return-Path: <netdev+bounces-102279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE603902360
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 16:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C6D1F27886
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B4A139579;
	Mon, 10 Jun 2024 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZfPh9izH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3F8563F
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028046; cv=none; b=HpbtOzmoa+gnBi7AMzvvPniYLSmhuiTaJrlERQgjbnHTW7TsqsHa2K+R3OvvMQRs5qh4KG6VjwFRBeV7sbEY48uJGgW/cd05w3I1eZ1unzXu2dK1/bB19qKB8pJNnaCrvfkv6/ZwQXNOvh4P00o25HMtS0P22QKl494j+xijd+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028046; c=relaxed/simple;
	bh=4kHftXR5FqbEQ5QAyLU+OS6rCkJ37cUf9COgoF7uN5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7dXHiLw0FYyT12ou4VjuUQjP5IdZwcq28r4C8GRxCBM6zPNxtsd0f6ieoapMQLR0ehs5lW88J9dDMDn51X3US+MWxe939mv+NIf6C54VDmYpt5yNB9SvsQKrfTJp8fsyXCzQmyAsEcouZ8CC8QhHCsLRkY2Jsk3p5Guks94lzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZfPh9izH; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a5bcfb2d3so3114201a12.3
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718028042; x=1718632842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fvt2qWurjYA3ThwvHUHGH6uNQ8vb5jTNZ+8JSbzPT2g=;
        b=ZfPh9izHeSGcw0aUkz3LLDz0G0LaQuYfGGOCc37KPaafxsdVLLvF8C6IaX6/X8LQM7
         Hx8cLbwB+RU6SFiJR6Mx5qrx1HapIRKNAbOZCuEwRUU2ZgfuO4kdlAZXw46DiEp8LloK
         FsxuA0QL3y2ya8tpdTE/IfsKa9zhOenNFhZu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718028042; x=1718632842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fvt2qWurjYA3ThwvHUHGH6uNQ8vb5jTNZ+8JSbzPT2g=;
        b=GQOXTGn3QtCzw4PIWhQqzhwwsItxP6XS3rBmID1SHncpsiKHbO3F53TEUNpzmjFAjr
         lQ2FvaaFjsdW4+wmKdjuns/r3uRawu3Av+PydFesdEluQkSQ/L0kBojead+rQhHF9KSq
         llm3AYU0RywqaF+5XnKo0/JW4nuljbsJTwxln+3QQi49bDWP7aeHTrN2DpYN+g9B5pZF
         1RJg/FT9UAo2uQQTIt7HYiE0LGuZU2JJVpRy/OPrjrOTkEa0O5dvD+J4w4iQjxjgjYtM
         TfSY7BUaayMy7okDnBos1n2mP4RC2meDLwcJ7SZPIPxIEpByXejM2I8Gv4ri7c8/2D9O
         FbTw==
X-Gm-Message-State: AOJu0YxMSdSDc2FJO/DkONlg4E6jWB8Cl6Ha8y84QY88QVyMGxAD21+A
	mTXqEq8IcXM3Tm/Cepj7NQ7EuMXqDp8ZYIWEk4G9oeeq16yafVjYau3nMFZXQ69DiNXVdnMU3Nn
	CHMMGW5usgzfK2G7PXP+TbykIGt9WZqfXj+NN
X-Google-Smtp-Source: AGHT+IFc3P1tRM0RTU6rurtoD0JJvuYpdV3/0C2AFFz8oSrkGLvR1b6RHO1B+EIz1isFsI6AwIyrKoXoufATCvyzK84=
X-Received: by 2002:a50:935a:0:b0:57c:7151:266f with SMTP id
 4fb4d7f45d1cf-57c71512af6mr3683096a12.34.1718028041895; Mon, 10 Jun 2024
 07:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608191335.52174-1-michael.chan@broadcom.com> <0cece70f-a7ae-47e2-a4a2-602d37063890@intel.com>
In-Reply-To: <0cece70f-a7ae-47e2-a4a2-602d37063890@intel.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Mon, 10 Jun 2024 07:00:29 -0700
Message-ID: <CACKFLikFP=xCKnZC_V+oEeFeS-i7PAKHmDFgZKBy+Sb1rKuTkw@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG
 forwarded response
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew.gospodarek@broadcom.com, horms@kernel.org, 
	Somnath Kotur <somnath.kotur@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	davem@davemloft.net
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000034f419061a8993e4"

--00000000000034f419061a8993e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 4:38=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 6/8/24 21:13, Michael Chan wrote:
> > Firmware interface 1.10.2.118 has increased the size of
> > HWRM_PORT_PHY_QCFG response beyond the maximum size that can be
> > forwarded.  When the VF's link state is not the default auto state,
> > the PF will need to forward the response back to the VF to indicate
> > the forced state.  This regression may cause the VF to fail to
> > initialize.
> >
> > Fix it by capping the HWRM_PORT_PHY_QCFG response to the maximum
> > 96 bytes.  The SPEEDS2_SUPPORTED flag needs to be cleared because the
> > new speeds2 fields are beyond the legacy structure.  Also modify
> > bnxt_hwrm_fwd_resp() to print a warning if the message size exceeds 96
> > bytes to make this failure more obvious.
> >
> > Fixes: 84a911db8305 ("bnxt_en: Update firmware interface to 1.10.2.118"=
)
> > Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> > Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> > ---
> > v2: Remove Bug and ChangeID from ChangeLog
> >      Add comment to explain the clearing of the SPEEDS2_SUPPORTED flag
> > ---
> >   drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 48 ++++++++++++++++++=
+
> >   .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 12 ++++-
> >   2 files changed, 58 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/et=
hernet/broadcom/bnxt/bnxt.h
> > index 656ab81c0272..94d242aca8d5 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > @@ -1434,6 +1434,54 @@ struct bnxt_l2_filter {
> >       atomic_t                refcnt;
> >   };
> >
> > +/* hwrm_port_phy_qcfg_output (size:96 bytes) */
> > +struct hwrm_port_phy_qcfg_output_compat {
>
> I assume that the first 96 bytes of the current
> struct hwrm_port_phy_qcfg are the same as here; with that you could wrap
> those there by struct_group_tagged, giving the very same name as here,
> but without replicating all the content.

Except for the valid bit at the end of the struct.  Let me see if I
can define the struct_group thing for 95 bytes and add the valid bit
here.  Thanks.

>
> > +     __le16  error_code;
> > +     __le16  req_type;
> > +     __le16  seq_id;
> > +     __le16  resp_len;
> > +     u8      link;
> > +     u8      active_fec_signal_mode;
> > +     __le16  link_speed;
> > +     u8      duplex_cfg;
> > +     u8      pause;
> > +     __le16  support_speeds;
> > +     __le16  force_link_speed;
> > +     u8      auto_mode;
> > +     u8      auto_pause;
> > +     __le16  auto_link_speed;
> > +     __le16  auto_link_speed_mask;
> > +     u8      wirespeed;
> > +     u8      lpbk;
> > +     u8      force_pause;
> > +     u8      module_status;
> > +     __le32  preemphasis;
> > +     u8      phy_maj;
> > +     u8      phy_min;
> > +     u8      phy_bld;
> > +     u8      phy_type;
> > +     u8      media_type;
> > +     u8      xcvr_pkg_type;
> > +     u8      eee_config_phy_addr;
> > +     u8      parallel_detect;
> > +     __le16  link_partner_adv_speeds;
> > +     u8      link_partner_adv_auto_mode;
> > +     u8      link_partner_adv_pause;
> > +     __le16  adv_eee_link_speed_mask;
> > +     __le16  link_partner_adv_eee_link_speed_mask;
> > +     __le32  xcvr_identifier_type_tx_lpi_timer;
> > +     __le16  fec_cfg;
> > +     u8      duplex_state;
> > +     u8      option_flags;
> > +     char    phy_vendor_name[16];
> > +     char    phy_vendor_partnumber[16];
> > +     __le16  support_pam4_speeds;
> > +     __le16  force_pam4_link_speed;
> > +     __le16  auto_pam4_link_speed_mask;
> > +     u8      link_partner_pam4_adv_speeds;
> > +     u8      valid;

This is the valid bit that is different.

> > +};

--00000000000034f419061a8993e4
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOr9lGG9u61OB+vdzgjDW5NnSXW6/LfS
wzuDA2vtvq1nMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDYx
MDE0MDA0MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBGKJCd9F+F46E+vxGX8p1grCQd8PTjb62n9qCsFqP3Kfkx0cby
zh2rF0a2MaZwPt5UF4PYvTfZv9zvk2fRlcem+sdW864Ytvh4X2wYenGlURxS3LU8tKIzyogAIoHE
BJkt75NG6hOZnTY6fNLpFgE141rc7+O+b4onvZTMrfv4SHqP6Q+hOzLf4/8uKjdasD6WG+2MITeP
A4ZpahMtSBuJxBTsEkWL0nDW9hmcdCgmXT3GdKwI9gY7UlSe6bvgRYTskNaTKWhtHXKNO165gD/z
F4piWGxWmz11+PqXgjW1OVY4zIeuRMHvXjPciMpJfSpiwMj7VRyH81X2Y6GfI0tw
--00000000000034f419061a8993e4--


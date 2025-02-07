Return-Path: <netdev+bounces-163795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 535B7A2B93B
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E35218884F5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0862942A;
	Fri,  7 Feb 2025 02:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZGRD0E++"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A9110E9
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 02:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738896394; cv=none; b=SP5xoMtOFPSIgn5TKsXwD5NLNiHK8G+id1qtg2vvF99DXlYjFsyil/AiwMKFGO93gUJI4lRW3vNWjCgtcRFCPxz/HujQnPTORsvd+ryQU9GhH/e9r683+3/X5WsxPMou5WuCT4raSU2K5lCB5EO6HyQLassDS8XT5O6AzSwNlas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738896394; c=relaxed/simple;
	bh=0n1847mZF9boJmjX8h+msbTssDrUKiv2dDitDl3rdDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpqYl30xnji7VRC8TypWlWLG0r86FsxKPfiNV9Fj9zyQGyxY2P2y3wSJL2pewalakP61J39k0TLEGrIsXJKw/f0F0AV61kiy0g9cJJPp+oMQjmZdpNHyPKl6xMrt37DqPqJeqs/2/VAS3r6JkkGTgbZTBPK4s+rjCT24ra2c/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZGRD0E++; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-219f8263ae0so32235995ad.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 18:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738896392; x=1739501192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=goedbKDfrNQP/88XU99yrW7KfdC3rBOZaNa37+OobNA=;
        b=ZGRD0E++TrFahp6/hqBGgkGZizDBeppxP4NoxVEBQHw8xvlAasr+oIDenl51WV0XU+
         xeDFBgc1OqlYxtjxf4wNhYSu+/woOn21x40ph2RvdAqAlN0HHUcimQX8osUrgxB95aPY
         rOLBeEAN7YSLJcnvrNiKsHdz62BBsymjAZ1k0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738896392; x=1739501192;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goedbKDfrNQP/88XU99yrW7KfdC3rBOZaNa37+OobNA=;
        b=OxRR9FihqGaesTWRvVAvVVSGRmO6oT7DC80xcptBrKSKvlrwjbtdAOT4Wv0ckJFGpd
         fQpG9Nkgs+i3tmVAnka9Pvs9mL1HgDQU8qnHgVs9fZ6qaHHwvBu6zb127jzn7GZltTB0
         fY4eO+KqDvlcgGlzTFx38dpLC5SPNycxCO875L64YOVTZHv1Vygv/mHEC+/up0SDhRX/
         nh5pFO7yd4XaIIhs4UHG1Iy7yVHcxcM5Pn4DqvI7AA2Kp0MmupaQSMot15R8tC+TjdBl
         lgdtxhGI8GHnDvY8ZLTIGjIMOnFURRQ2C0PdXqtbhu6/jUx5b7clZtnqP641y4w9iIZ+
         SdyA==
X-Forwarded-Encrypted: i=1; AJvYcCXtbPb/9ArdVWg4zx/OAzh7lMyDUxwhkClRL17Qmpwmj90snP25ZUVcLMUZCicDafxRl4gTfPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywvzSmH9WL6H+Hs5fSc7A0WHajhhUVsRnp3WATbRhzMu2Ie4jI
	BiHZf8019kXeYQm3szdKiL9/uTJX8Td+VCt8WLCZW0DR5W6BDjjq9yHOXQkBPGnyirlszuT46vA
	v2wuj/XVp4ewXnOJ7AFF/Nr+r7llMajVAsyx7
X-Gm-Gg: ASbGncu+M5OkPFFeyFnEP+9IH43qYOFazGsS3L5yMD1EPFJGCl/c8k32/IBNxjYY9sw
	XMgZFl8NoYHLbVFHFBjOn6c+9DaC9vYz+RIuUfGDC1clauusjF4I8Q77Ne2rFKu8R2YWcLY9FRQ
	==
X-Google-Smtp-Source: AGHT+IEabN8ncxEFQ2uovL3W6dAfBvj+AGTgaIe9S6fUKuKATHDUOMf1C/cIldadihOE09Q2sJKKJ+2Yvg8dFyVU4EU=
X-Received: by 2002:a05:6a20:9f43:b0:1ed:8cd8:77fb with SMTP id
 adf61e73a8af0-1ee03a3f4d5mr3280374637.16.1738896391854; Thu, 06 Feb 2025
 18:46:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206235334.1425329-1-kuba@kernel.org> <20250206235334.1425329-8-kuba@kernel.org>
In-Reply-To: <20250206235334.1425329-8-kuba@kernel.org>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Fri, 7 Feb 2025 08:16:18 +0530
X-Gm-Features: AWEUYZn4E1zoVu2owlOLqBzbwMBfUDaIyPg640hCRRFL9dmcvFJ6RXw0CIxVjmE
Message-ID: <CAH-L+nPhLzOyJnCRs9mQb=C4D8KF2oHk6uObYhLLg-aEFiGqhQ@mail.gmail.com>
Subject: Re: [PATCH net-next 7/7] eth: fbnic: support listing tcam content via debugfs
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Alexander Duyck <alexanderduyck@meta.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c233e4062d845d77"

--000000000000c233e4062d845d77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

One minor nit in line. Looks good otherwise.

On Fri, Feb 7, 2025 at 5:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> From: Alexander Duyck <alexanderduyck@meta.com>
>
> The device has a handful of relatively small TCAM tables,
> support dumping the driver state via debugfs.
>
>   # ethtool -N eth0 flow-type tcp6 \
>       dst-ip 1111::2222 dst-port $((0x1122)) \
>       src-ip 3333::4444 src-port $((0x3344)) \
>       action 2
>   Added rule with ID 47
>
>   # cd $dbgfs
>   # cat ip_src
>   Idx S TCAM Bitmap       V Addr/Mask
>   ------------------------------------
>   00  1 00020000,00000000 6 33330000000000000000000000004444
>                             00000000000000000000000000000000
>   ...
>   # cat ip_dst
>   Idx S TCAM Bitmap       V Addr/Mask
>   ------------------------------------
>   00  1 00020000,00000000 6 11110000000000000000000000002222
>                             00000000000000000000000000000000
>   ...
>
>   # cat act_tcam
>   Idx S Value/Mask                                              RSS  Dest
>   -----------------------------------------------------------------------=
-
>   ...
>   49  1 0000 0000 0000 0000 0000 0000 1122 3344 0000 9c00 0088  000f 0000=
0212
>         ffff ffff ffff ffff ffff ffff 0000 0000 ffff 23ff ff00
>   ...
>
> The ipo_* tables are for outer IP addresses.
> The tce_* table is for directing/stealing traffic to NC-SI.
>
> Signed-off-by: Alexander Duyck <alexanderduyck@meta.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../net/ethernet/meta/fbnic/fbnic_debugfs.c   | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c b/drivers/ne=
t/ethernet/meta/fbnic/fbnic_debugfs.c
> index ac80981f67c0..e8f2d7f2d962 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_debugfs.c
> @@ -44,6 +44,132 @@ static int fbnic_dbg_mac_addr_show(struct seq_file *s=
, void *v)
>  }
>  DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_mac_addr);
>
> +static int fbnic_dbg_tce_tcam_show(struct seq_file *s, void *v)
> +{
> +       struct fbnic_dev *fbd =3D s->private;
> +       int i, tcam_idx =3D 0;
> +       char hdr[80];
This magic number, 80 is used at multiple places. Can you have a macro for =
this?
> +
> +       /* Generate Header */
> +       snprintf(hdr, sizeof(hdr), "%3s %s %-17s %s\n",
> +                "Idx", "S", "TCAM Bitmap", "Addr/Mask");
> +       seq_puts(s, hdr);
> +       fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
> +
> +       for (i =3D 0; i < ARRAY_SIZE(fbd->mac_addr); i++) {
> +               struct fbnic_mac_addr *mac_addr =3D &fbd->mac_addr[i];
> +
> +               /* Verify BMC bit is set */
> +               if (!test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam))
> +                       continue;
> +
> +               if (tcam_idx =3D=3D FBNIC_TCE_TCAM_NUM_ENTRIES)
> +                       break;
> +
> +               seq_printf(s, "%02d  %d %64pb %pm\n",
> +                          tcam_idx, mac_addr->state, mac_addr->act_tcam,
> +                          mac_addr->value.addr8);
> +               seq_printf(s, "                        %pm\n",
> +                          mac_addr->mask.addr8);
> +               tcam_idx++;
> +       }
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_tce_tcam);
> +
> +static int fbnic_dbg_act_tcam_show(struct seq_file *s, void *v)
> +{
> +       struct fbnic_dev *fbd =3D s->private;
> +       char hdr[80];
> +       int i;
> +
> +       /* Generate Header */
> +       snprintf(hdr, sizeof(hdr), "%3s %s %-55s %-4s %s\n",
> +                "Idx", "S", "Value/Mask", "RSS", "Dest");
> +       seq_puts(s, hdr);
> +       fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
> +
> +       for (i =3D 0; i < FBNIC_RPC_TCAM_ACT_NUM_ENTRIES; i++) {
> +               struct fbnic_act_tcam *act_tcam =3D &fbd->act_tcam[i];
> +
> +               seq_printf(s, "%02d  %d %04x %04x %04x %04x %04x %04x %04=
x %04x %04x %04x %04x  %04x %08x\n",
> +                          i, act_tcam->state,
> +                          act_tcam->value.tcam[10], act_tcam->value.tcam=
[9],
> +                          act_tcam->value.tcam[8], act_tcam->value.tcam[=
7],
> +                          act_tcam->value.tcam[6], act_tcam->value.tcam[=
5],
> +                          act_tcam->value.tcam[4], act_tcam->value.tcam[=
3],
> +                          act_tcam->value.tcam[2], act_tcam->value.tcam[=
1],
> +                          act_tcam->value.tcam[0], act_tcam->rss_en_mask=
,
> +                          act_tcam->dest);
> +               seq_printf(s, "      %04x %04x %04x %04x %04x %04x %04x %=
04x %04x %04x %04x\n",
> +                          act_tcam->mask.tcam[10], act_tcam->mask.tcam[9=
],
> +                          act_tcam->mask.tcam[8], act_tcam->mask.tcam[7]=
,
> +                          act_tcam->mask.tcam[6], act_tcam->mask.tcam[5]=
,
> +                          act_tcam->mask.tcam[4], act_tcam->mask.tcam[3]=
,
> +                          act_tcam->mask.tcam[2], act_tcam->mask.tcam[1]=
,
> +                          act_tcam->mask.tcam[0]);
> +       }
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_act_tcam);
> +
> +static int fbnic_dbg_ip_addr_show(struct seq_file *s,
> +                                 struct fbnic_ip_addr *ip_addr)
> +{
> +       char hdr[80];
> +       int i;
> +
> +       /* Generate Header */
> +       snprintf(hdr, sizeof(hdr), "%3s %s %-17s %s %s\n",
> +                "Idx", "S", "TCAM Bitmap", "V", "Addr/Mask");
> +       seq_puts(s, hdr);
> +       fbnic_dbg_desc_break(s, strnlen(hdr, sizeof(hdr)));
> +
> +       for (i =3D 0; i < FBNIC_RPC_TCAM_IP_ADDR_NUM_ENTRIES; i++, ip_add=
r++) {
> +               seq_printf(s, "%02d  %d %64pb %d %pi6\n",
> +                          i, ip_addr->state, ip_addr->act_tcam,
> +                          ip_addr->version, &ip_addr->value);
> +               seq_printf(s, "                          %pi6\n",
> +                          &ip_addr->mask);
> +       }
> +
> +       return 0;
> +}
> +
> +static int fbnic_dbg_ip_src_show(struct seq_file *s, void *v)
> +{
> +       struct fbnic_dev *fbd =3D s->private;
> +
> +       return fbnic_dbg_ip_addr_show(s, fbd->ip_src);
> +}
> +DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_ip_src);
> +
> +static int fbnic_dbg_ip_dst_show(struct seq_file *s, void *v)
> +{
> +       struct fbnic_dev *fbd =3D s->private;
> +
> +       return fbnic_dbg_ip_addr_show(s, fbd->ip_dst);
> +}
> +DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_ip_dst);
> +
> +static int fbnic_dbg_ipo_src_show(struct seq_file *s, void *v)
> +{
> +       struct fbnic_dev *fbd =3D s->private;
> +
> +       return fbnic_dbg_ip_addr_show(s, fbd->ipo_src);
> +}
> +DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_ipo_src);
> +
> +static int fbnic_dbg_ipo_dst_show(struct seq_file *s, void *v)
> +{
> +       struct fbnic_dev *fbd =3D s->private;
> +
> +       return fbnic_dbg_ip_addr_show(s, fbd->ipo_dst);
> +}
> +DEFINE_SHOW_ATTRIBUTE(fbnic_dbg_ipo_dst);
> +
>  static int fbnic_dbg_pcie_stats_show(struct seq_file *s, void *v)
>  {
>         struct fbnic_dev *fbd =3D s->private;
> @@ -84,6 +210,18 @@ void fbnic_dbg_fbd_init(struct fbnic_dev *fbd)
>                             &fbnic_dbg_pcie_stats_fops);
>         debugfs_create_file("mac_addr", 0400, fbd->dbg_fbd, fbd,
>                             &fbnic_dbg_mac_addr_fops);
> +       debugfs_create_file("tce_tcam", 0400, fbd->dbg_fbd, fbd,
> +                           &fbnic_dbg_tce_tcam_fops);
> +       debugfs_create_file("act_tcam", 0400, fbd->dbg_fbd, fbd,
> +                           &fbnic_dbg_act_tcam_fops);
> +       debugfs_create_file("ip_src", 0400, fbd->dbg_fbd, fbd,
> +                           &fbnic_dbg_ip_src_fops);
> +       debugfs_create_file("ip_dst", 0400, fbd->dbg_fbd, fbd,
> +                           &fbnic_dbg_ip_dst_fops);
> +       debugfs_create_file("ipo_src", 0400, fbd->dbg_fbd, fbd,
> +                           &fbnic_dbg_ipo_src_fops);
> +       debugfs_create_file("ipo_dst", 0400, fbd->dbg_fbd, fbd,
> +                           &fbnic_dbg_ipo_dst_fops);
>  }
>
>  void fbnic_dbg_fbd_exit(struct fbnic_dev *fbd)
> --
> 2.48.1
>
>


--=20
Regards,
Kalesh AP

--000000000000c233e4062d845d77
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEIGEobWFcAFZNOQNrxahMs7rSTOIamT0k3V8vzSXPdKPEMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1MDIwNzAyNDYzMlowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA3lQ+raR7w
7jYEGJjmtzF1N7NH+nXmzOzsyb63nm4g99B5fC6IDIM9XRuITpYEz8qRX4izuzd6Y4cpTS/o0W4a
9o3YIJktagpudcR+x6buXnLKAVlEQge38pMN6BQjFDCoNQoBGqgNnamoV87P+I5P2d6qXymzgM8E
lGxL84omN54MONamvbNnzrotPiLa67mEl3PogfvMu4uxlUd10BKyS0Ou/Le+UGoOLjDgmeUVWxq6
XMBH0SFCsNpQrmbBF8Sf54gcx64EUaiykVWc9h+CyMR9J7S5NtVYS3TvW51clcBjwKMZyfAGj+r0
yDMLpRWCI8ZjCPzZnLhMFlNuLoBL
--000000000000c233e4062d845d77--


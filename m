Return-Path: <netdev+bounces-241476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED0DC84411
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159C83AB9A0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6E22D7813;
	Tue, 25 Nov 2025 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YkOjMEb1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31BA2D9EC9
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764063435; cv=none; b=pbkKsJ0m34ENyNsADDncMUFAA8SnHx/cffOhErmzodc/SzUm8SH2jikDVqovn+lSwIITe0MmIgy3fG5p7pzgmtMLCbeO9neN5dx+jsOC+ds+a9Fl/Ypii3Prsp32Avi9asroZv9IM8d7mCr94WRuQgYrHa9vAo4/5VDuGsFT9wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764063435; c=relaxed/simple;
	bh=Pfqx1R4KSiiCMvbBFzZPxUjKTm3xiAWosf7O89H/yhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScmteBkwgC2R1hrNpNPIuHrY3eIi47XcYKqaZt676t+++NSOhFBYnnmeYkhwymEEpzgudbCESlMsiSPB/7Et3VCAPWnjRid3vD6qGgwmRYjFMAcmPQgOGiB3y78gqVhVe07baDVFeGDWLdDO9vjciC5Uk/eHwqahRubArbO+qEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YkOjMEb1; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-641e942242cso4464112d50.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 01:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764063433; x=1764668233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYBFUVHoqCaLWAMbSxzHSde6yoNWW5hdv8XZ1B4SwKE=;
        b=v2bxmg7tMwbzULnGlOM3VhOMnTbnIVwbw25ZiA+kb2J3O9lps6CTKmWmnsfEnWC1Xf
         9y3asJ/yB/sFTjnTXSE/6YczerWbHkc2reMxtEgoABp+tbw4gymsF4ZvIUk4ZsQ+QW3l
         VASiTm4G4iE9/hoB/FY8uKgqFxpxDI9aKveRt1+Ukj537CMdIPzZzhS9Gcq5j5i4wmzX
         YtosXsF9HTk7qJbQgHm+AcURVLOwmTrixDh+GKwj82HBsawN8rc1RyKHDAly7vQ9tF5k
         vqUPMcSkc5AaMzHP1xFiQxsyHbranP3z0ii16qWSHoxAyHRXmajTGhpXO7OoZsnPEB1i
         ebLw==
X-Forwarded-Encrypted: i=1; AJvYcCUzO9hxKtisaUTtbw8cjKULUWpZTD91/okIWOGEIdj4mp5N01KPyCdQuV0DmICiFHRyerJMt4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YytYijEJzWDKpYEvmg1v2zC8MFdQWcAyttMkEyfVmmbYU34CQQ/
	UjkmbHcLwAlJCXT6QoHZNgYJhmQ/U5ypVIFvaGpi9lcWcbSD5xpz6Z8pHFS4LPlal2FaYeWvqPo
	XEvhxbWQ17rQi7l5tBhyISPva0aeZFPJcTKE1qNUDTPLIT2YK8I+Hmtx8B/4lRmXMdlx6rlC6Kf
	aGZyit0+TxYoSEMRnhYDgaKbAyeh72Pj5/HSWelBLfFLo+buuyX+uniQjk9s0ZkD1lMLrJG1eCF
	utkqnc9gJhC8N3PRA==
X-Gm-Gg: ASbGncsuABLxGFfLUPYHAuW424wRiCxF30vjseqxFCizw0FWzRJ0VcJ/yQhzlMGzWZV
	0VnJjVj54tr+PXB5fbC8w8Fb0aCwMeIWHKZpOZzEhjQu8i8M9ioeI2TzGNTAs8Wz/I40rLXxfWl
	+SF1I51MaFgjuNWN/ldnRiSiYqJ1KF3bUcJKerFARzFMgcNPgFOkSmXYfMI7f8+Tx2hJBv6IxkA
	1YNIHxW4NNd935My5BpHx9o6mdTeuE54TnNt3gn2qBJGijn3ShbQ5Oi+Wog4HbPypyRAmUplgeu
	bi733HmipQaWJqfccPwNkVI+ov1aD2Z44IaqzdzYEH6+x72HlgZ+vaDel5YFuopZvhtyu/H4QRc
	6ahKED9XHyieG0F61nckpHco+psj5yS0FgtdZOduKkkIaqgXMCbWoHwNzTdRSVJCu0G9Cl+nObQ
	np/X2CbdfoElWEMPOKRq8rtVcYcbUYn32TNZbEs8ccYcfCApCJla4=
X-Google-Smtp-Source: AGHT+IHrYEfhKVGNCvAlCZgc/ET5fGCmeu8PTZMQSvmdW4XEgyfH9LipNo50wbIUM+Uyfdc5907UQMieGlvK
X-Received: by 2002:a05:690e:1550:20b0:63f:baef:c5b with SMTP id 956f58d0204a3-64302af0971mr8785070d50.44.1764063432726;
        Tue, 25 Nov 2025 01:37:12 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-642f705ff71sm1220557d50.3.2025.11.25.01.37.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2025 01:37:12 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ba4c6ac8406so4134268a12.0
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 01:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764063431; x=1764668231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wYBFUVHoqCaLWAMbSxzHSde6yoNWW5hdv8XZ1B4SwKE=;
        b=YkOjMEb1EYLe2fyyGOdKBVSKntRiZ/Ht8dS+hqpVPsQYo6QmWEtV/j3JZQWKmzuOCM
         ZG2lkQNOP79opoBK2SuW9BgG+lNdMTrGzGMoSXThZEzFo117eXlrx6kpetJeJJQuEEK3
         E8sAhgwKIiL4o2RsH0OCXON6FkHckC1M8MvL8=
X-Forwarded-Encrypted: i=1; AJvYcCWuSXayWtCr/tNCBTH5rA7ce4Pa1o5t18vMYHebPk1V2gMWlNPs6xRXn532jYDU0M820TVxYkg=@vger.kernel.org
X-Received: by 2002:a05:693c:228a:b0:2a4:3593:ddf6 with SMTP id 5a478bee46e88-2a71a024d77mr9777935eec.35.1764063431153;
        Tue, 25 Nov 2025 01:37:11 -0800 (PST)
X-Received: by 2002:a05:693c:228a:b0:2a4:3593:ddf6 with SMTP id
 5a478bee46e88-2a71a024d77mr9777918eec.35.1764063430660; Tue, 25 Nov 2025
 01:37:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
 <20251114195312.22863-11-bhargava.marreddy@broadcom.com> <dff2924b-745e-45eb-bff6-f0c6798a61cf@oracle.com>
In-Reply-To: <dff2924b-745e-45eb-bff6-f0c6798a61cf@oracle.com>
From: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Date: Tue, 25 Nov 2025 15:06:57 +0530
X-Gm-Features: AWmQ_blS1MGiK8oFAXjtJf7Bvb_0QE6M4GLY_FPH0dDeODlabuZk9GzgDeI2S2Q
Message-ID: <CANXQDtYmYuUViG+9oOwETjBsyuJ1Gt8GPSKgn9oHCx9TokVLxQ@mail.gmail.com>
Subject: Re: [External] : [v2, net-next 10/12] bng_en: Add initial support for
 ethtool stats display
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	vsrama-krishna.nemani@broadcom.com, vikas.gupta@broadcom.com, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003315ef064468063f"

--0000000000003315ef064468063f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 7:37=E2=80=AFPM ALOK TIWARI <alok.a.tiwari@oracle.c=
om> wrote:
> > +     BNGE_TX_STATS_ENTRY(tx_pause_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_pfc_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_jabber_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_fcs_err_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_err),
> > +     BNGE_TX_STATS_ENTRY(tx_fifo_underruns),
> > +     BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri0),
> > +     BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri1),
> > +     BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri2),
> > +     BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri3),
> > +     BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri4),
> > +     BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri5),
> > +     BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri6),
> > +     BNGE_TX_STATS_ENTRY(tx_pfc_ena_frames_pri7),
> > +     BNGE_TX_STATS_ENTRY(tx_eee_lpi_events),
> > +     BNGE_TX_STATS_ENTRY(tx_eee_lpi_duration),
> > +     BNGE_TX_STATS_ENTRY(tx_total_collisions),
> > +     BNGE_TX_STATS_ENTRY(tx_bytes),
> > +     BNGE_TX_STATS_ENTRY(tx_xthol_frames),
> > +     BNGE_TX_STATS_ENTRY(tx_stat_discard),
> > +     BNGE_TX_STATS_ENTRY(tx_stat_error),
>
> RX uses rx_stat_err. Consider using consistent err/error
> same for rx_jbr_frames and tx_jabber_frames

It is consistent with the shared firmware header struct, so we prefer
to keep it like this.

Thanks,
Bhargava Marreddy

>
> > +};
> > +
> > +static const struct {
> > +     long offset;
> > +     char string[ETH_GSTRING_LEN];
> > +} bnge_port_stats_ext_arr[] =3D {
> > +     BNGE_RX_STATS_EXT_ENTRY(link_down_events),
> > +     BNGE_RX_STATS_EXT_ENTRY(continuous_pause_events),
> > +     BNGE_RX_STATS_EXT_ENTRY(resume_pause_events),
> > +     BNGE_RX_STATS_EXT_ENTRY(continuous_roce_pause_events),
> > +     BNGE_RX_STATS_EXT_ENTRY(resume_roce_pause_events),
> > +     BNGE_RX_STATS_EXT_COS_ENTRIES,
> > +     BNGE_RX_STATS_EXT_PFC_ENTRIES,
> > +     BNGE_RX_STATS_EXT_ENTRY(rx_bits),
> > +     BNGE_RX_STATS_EXT_ENTRY(rx_buffer_passed_threshold),
> > +     BNGE_RX_STATS_EXT_ENTRY(rx_pcs_symbol_err),
> > +     BNGE_RX_STATS_EXT_ENTRY(rx_corrected_bits),
> > +     BNGE_RX_STATS_EXT_DISCARD_COS_ENTRIES,
> > +     BNGE_RX_STATS_EXT_ENTRY(rx_fec_corrected_blocks),
> > +     BNGE_RX_STATS_EXT_ENTRY(rx_fec_uncorrectable_blocks),
> > +     BNGE_RX_STATS_EXT_ENTRY(rx_filter_miss),
> > +};
> > +
> Thanks,
> Alok

--0000000000003315ef064468063f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGqjCCBJKg
AwIBAgIMFJTEEB7G+bRSFHogMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTI1NVoXDTI3MDYyMTEzNTI1NVowge0xCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzERMA8GA1UEBBMITWFycmVkZHkxGDAWBgNVBCoTD0JoYXJnYXZhIENoZW5uYTEWMBQGA1UE
ChMNQlJPQURDT00gSU5DLjEnMCUGA1UEAwweYmhhcmdhdmEubWFycmVkZHlAYnJvYWRjb20uY29t
MS0wKwYJKoZIhvcNAQkBFh5iaGFyZ2F2YS5tYXJyZWRkeUBicm9hZGNvbS5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCq1sbXItt9Z31lzjb1WqEEegmLi72l7kDsxOJCWBCSkART
C/LTHOEoELrltkLJnRJiEujzwxS1/cV0LQse38GKog0UmiG5Jsq4YbNxmC7s3BhuuZYSoyCQ7Jg+
BzqQDU+k9ESjiD/R/11eODWJOxHipYabn/b+qYM+7CTSlVAy7vlJ+z1E/LnygVYHkWFN+IJSuY26
OWgSyvM8/+TPOrECYbo+kLcjqZfLS9/8EDThXQgg9oCeQOD8pwExycHc9w6ohJLoK7mVWrDol6cl
vW0XPONZARkdcZ69nJIHt/aMhihlyTUEqD0R8yRHfBp9nQwoSs8z+8xZ+cczX/XvtCVJAgMBAAGj
ggHiMIIB3jAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADCBkwYIKwYBBQUHAQEEgYYwgYMw
RgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjZz
bWltZWNhMjAyMy5jcnQwOQYIKwYBBQUHMAGGLWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMzBlBgNVHSAEXjBcMAkGB2eBDAEFAwMwCwYJKwYBBAGgMgEoMEIGCisG
AQQBoDIKAwIwNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3Np
dG9yeS8wQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2
c21pbWVjYTIwMjMuY3JsMCkGA1UdEQQiMCCBHmJoYXJnYXZhLm1hcnJlZGR5QGJyb2FkY29tLmNv
bTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAd
BgNVHQ4EFgQUkiPQZ5IKnCUHj3xJyO85n4OdVl4wDQYJKoZIhvcNAQELBQADggIBALtu8uco00Hh
dGp+c7lMOYHnFquYd6CXMYL1sBTi51PmiOKDO2xgfVvR7XI/kkqK5Iut0PYzv7kvUJUpG7zmL+XW
ABC2V9jvp5rUPlGSfP9Ugwx7yoGYEO+x42LeSKypUNV0UbBO8p32C1C/OkqikHlrQGuy8oUMNvOl
rrSoYMXdlZEravXgTAGO1PLgwVHEpXKy+D523j8B7GfDKHG7M7FjuqqyuxiDvFSoo3iEjYVzKZO9
NkcawmbO73W8o/5QE6GiIIvXyc+YUfVSNmX5/XpZFqbJ/uFhmiMmBhsT7xJA+L0NHTR7m09xCfZd
+XauyU42jyqUrgRWA36o20SMf1IURZYWgH4V7gWF2f95BiJs0uV1ddjo5ND4pejlKGkCGBfXSAWP
Ye5wAfgaC3LLKUnpYc3o6q5rUrhp9JlPey7HcnY9yJzQsw++DgKprh9TM/9jwlek8Kw1SIIiaFry
iriecfkPEiR9HVip63lbWsOrBFyroVEsNmmWQYKaDM4DLIDItDZNDw0FgM1b6R/E2M0ME1Dibn8P
alTJmpepLqlS2uwywOFZMLeiiVfTYSHwV/Gikq70KjVLNF59BWZMtRvyD5EoPHQavcOQTr7I/5Gc
GboBOYvJvkYzugiHmztSchEvGtPA10eDOxR1voXJlPH95MB73ZQwqQNpRPq04ElwMYICVzCCAlMC
AQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMf
R2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMFJTEEB7G+bRSFHogMA0GCWCGSAFlAwQC
AQUAoIHHMC8GCSqGSIb3DQEJBDEiBCBA14VpxaH4cZQnrJ/Z5eEq+ffR4ABrLu62RpDD1m5JhDAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTExMjUwOTM3MTFaMFwG
CSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYI
KoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAAqkA/
gyP3emRWvaQCfHZfYLGJWEz+r152nvgWh4BUFABb8K5OVYHWnYBInae3ILDylub24Jcv0+lKD3Dn
/znaSojrxyUHwpINbhUXgMQJdcttAhzEK7lysp8PG8cFJ1xtsvZmpXtKnGr9GrSW6mUfmDzEBIMN
ex949mqQHG8Ec1eh1s/3qMvRwUIZCGVsRZjRe/ZmWcLNQ+ht2RA60lemietZJ5VKde8vQ7YgRrW4
QZqF34icyKUmbBcUiGzeR82aoQD+yJQlC/bYov5A55RYe4MvEds2MdYYwWVDfrd9KkwkgGjm1/ex
SLyyc4CMOQTi+v+CRF7O+78kn9ZvWKKu
--0000000000003315ef064468063f--


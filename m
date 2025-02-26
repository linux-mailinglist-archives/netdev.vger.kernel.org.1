Return-Path: <netdev+bounces-169720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99D8A455F4
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A664188CB7F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D3D2686A5;
	Wed, 26 Feb 2025 06:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q8RdqqMW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9FB26770A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740552176; cv=none; b=g0h6GSezZMEaqXA1jC/i89SBIjqUbOxMN+Lg0dtaNJ1FEolewDsk1hUiXlrw5WsyDxtYY6stSY82hWnHXIio6GWWPgM5ibMv3bHFxFPcEyxl9/6rDEVIMyy1oV4TSktfnLzSZzIhPRx2Vtq3t5sEdkiAFZV3xHueXW4tLWW+rUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740552176; c=relaxed/simple;
	bh=byiYEFKoAf9b+7VQITMP/ypgHxlEbUYn9KMAS77mgIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSE9A/l8ILEVMoT86b3Yw7Cnmn/C9I8djz0GqiqsD8+OaUaSiA6Dc1m3X0BG3ER8QRjCy37+n8MPhrfyc9t9p+xB5uGSajEhpMKPkwx5yT0iDnnMdwCVxszIbtPqhUSWi+Yv9q+HX3qzc6nPZSCTLTafxCnOUm6k1U8uIQX4nT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q8RdqqMW; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86b0899ad8bso809225241.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 22:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740552173; x=1741156973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MD8GmibUIKbFaJKZbYO/osjWHfFIEiMMB02g8WxgPZ8=;
        b=Q8RdqqMWWo57DSnTZ4Ib/vwNWAF9ILBDH4fSE3H+WPCwNZES/C66y4EI5cUqxHx/W5
         t/G7AhpixVY9/tMnlEz4D44nqzIPNsscQrkXWymkMM1GqGsIo9NWByi1Fn5Qdc4K9c7U
         SYuxZdMcdUbamcy3kV91byDZfpG+sO5o3eER0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740552173; x=1741156973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MD8GmibUIKbFaJKZbYO/osjWHfFIEiMMB02g8WxgPZ8=;
        b=M+QdxUWR6GX9krw6pKkAj1xMiWsKZOcTeLET9b0KIOMueuUPvxn9AoRJeW5QKL7jIY
         TJk+TNYtmZ+ywEmpkXkQ2NFPB+C6gENikQNWgBciFoi1NV/kzmb/BtMP9KYXinTLc26u
         KOwdISFpdpSKauZrbRpYP023o1Dl5Ob0U9XXv5aP9evQXMCrndRZ7vmPcodvXO3hc1Zw
         5bFe2upe4WMrZCMkccqdxPjOM0NFakgy/30kAKlNdegzXDT+ZmgAdz/7VKcItyFHO7x7
         sYQOgFBWhURPjM/33y7AbRmGUJSWFN1bv7LfA9YvO/L5scDYwAs1vH4JD9TaflbQt077
         O/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUy27lNwqeLLzypV9RRFZ57BQsj+zVT1jE+N0eLnYBifcRAIpbJS2vAQX8c47cR3TX/DfdjV8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAQeATownzviPxuJ7sSWyrb4QDdjajUD4KKvrC8MxgqUj0U7S6
	+4Na0IlZ4X9A2qa1fL/CJP5GacB49h+YqQCfeXFoMQFxSPxh72aGUqJk6uQOZBYfdY0mNSEpvz2
	Se1e2JgSbFqeC+/cruXhPn/VcHb4inBDSczIX
X-Gm-Gg: ASbGnctw40BeJOIF8prIP7H+8IpCWK+YhABE6ywg27iPyz4iIAShHKwgl6/W1N/VzBI
	D0FAW8bX9RXazoc1+f0YMNCL0+PibCHWPcmVGHCaVi758jjQpQNtt9n2Xr6EFxgCFUz9ScQlzPk
	L95DEtFj2D
X-Google-Smtp-Source: AGHT+IGLNOICdkwb64qpBEIZuSti5TatkAc5D638L5ZFVHFchFFRQkNcUoJUjmmAOMgYov0bGNmMGUKVxHIRcJLoUK0=
X-Received: by 2002:a05:6102:370f:b0:4bb:d7f0:6e70 with SMTP id
 ada2fe7eead31-4c00ad0bf5fmr3873119137.5.1740552173494; Tue, 25 Feb 2025
 22:42:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226061837.1435731-1-ap420073@gmail.com> <20250226061837.1435731-3-ap420073@gmail.com>
In-Reply-To: <20250226061837.1435731-3-ap420073@gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Wed, 26 Feb 2025 12:12:41 +0530
X-Gm-Features: AQ5f1JoGTxLp1iPljAyarU1B2qUT8nxb1ht1bzxTf6xyz_FcWBvO93zYLNcY83U
Message-ID: <CAOBf=mt0w=tTSQ03hdgumw=sJ8bOegZ23Toasj+kuYvOo+S2Yw@mail.gmail.com>
Subject: Re: [PATCH net 2/3] eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, gospo@broadcom.com, 
	dw@davidwei.uk, horms@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000812c9062f05e2cc"

--0000000000000812c9062f05e2cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 11:49=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> The bnxt_queue_mem_alloc() is called to allocate new queue memory when
> a queue is restarted.
> It internally accesses rx buffer descriptor corresponding to the index.
> The rx buffer descriptor is allocated and set when the interface is up
> and it's freed when the interface is down.
> So, if queue is restarted if interface is down, kernel panic occurs.
>
> Splat looks like:
>  BUG: unable to handle page fault for address: 000000000000b240
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 3 UID: 0 PID: 1563 Comm: ncdevmem2 Not tainted 6.14.0-rc2+ #9 844dd=
ba6e7c459cafd0bf4db9a3198e
>  Hardware name: ASUS System Product Name/PRIME Z690-P D4, BIOS 0603 11/01=
/2021
>  RIP: 0010:bnxt_queue_mem_alloc+0x3f/0x4e0 [bnxt_en]
>  Code: 41 54 4d 89 c4 4d 69 c0 c0 05 00 00 55 48 89 f5 53 48 89 fb 4c 8d =
b5 40 05 00 00 48 83 ec 15
>  RSP: 0018:ffff9dcc83fef9e8 EFLAGS: 00010202
>  RAX: ffffffffc0457720 RBX: ffff934ed8d40000 RCX: 0000000000000000
>  RDX: 000000000000001f RSI: ffff934ea508f800 RDI: ffff934ea508f808
>  RBP: ffff934ea508f800 R08: 000000000000b240 R09: ffff934e84f4b000
>  R10: ffff9dcc83fefa30 R11: ffff934e84f4b000 R12: 000000000000001f
>  R13: ffff934ed8d40ac0 R14: ffff934ea508fd40 R15: ffff934e84f4b000
>  FS:  00007fa73888c740(0000) GS:ffff93559f780000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000000000b240 CR3: 0000000145a2e000 CR4: 00000000007506f0
>  PKRU: 55555554
>  Call Trace:
>   <TASK>
>   ? __die+0x20/0x70
>   ? page_fault_oops+0x15a/0x460
>   ? exc_page_fault+0x6e/0x180
>   ? asm_exc_page_fault+0x22/0x30
>   ? __pfx_bnxt_queue_mem_alloc+0x10/0x10 [bnxt_en 7f85e76f4d724ba07471d7e=
39d9e773aea6597b7]
>   ? bnxt_queue_mem_alloc+0x3f/0x4e0 [bnxt_en 7f85e76f4d724ba07471d7e39d9e=
773aea6597b7]
>   netdev_rx_queue_restart+0xc5/0x240
>   net_devmem_bind_dmabuf_to_queue+0xf8/0x200
>   netdev_nl_bind_rx_doit+0x3a7/0x450
>   genl_family_rcv_msg_doit+0xd9/0x130
>   genl_rcv_msg+0x184/0x2b0
>   ? __pfx_netdev_nl_bind_rx_doit+0x10/0x10
>   ? __pfx_genl_rcv_msg+0x10/0x10
>   netlink_rcv_skb+0x54/0x100
>   genl_rcv+0x24/0x40
> ...
>
> Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index 7b8b5b39c7bb..1f7042248ccc 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15439,6 +15439,9 @@ static int bnxt_queue_mem_alloc(struct net_device=
 *dev, void *qmem, int idx)
>         struct bnxt_ring_struct *ring;
>         int rc;
>
> +       if (!bp->rx_ring)
> +               return -ENETDOWN;
> +
>         rxr =3D &bp->rx_ring[idx];
>         clone =3D qmem;
>         memcpy(clone, rxr, sizeof(*rxr));
> --
> 2.34.1
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--0000000000000812c9062f05e2cc
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
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN/JxVFLAO2+ct1M5d7NdHZd+L2i
3KkyENWhnIDqnZBmMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDIyNjA2NDI1M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCUvZuHUHjX0aSi6LpVs3pDpdtp6DMdbvcHWanidfuU+5Uz
aPRYUfiPBQtU8GdGAVBEGO4Tl3N6DvsCw/HHoS8pxteu0Erb/pxSOSXTUaH/ANDCPUzsUahtsnG5
LMquWgkjdL7RtNUSEJz9nrCYOowtH2KexxCUf//modw7CLb6ngC3tlJxu/u/y7D5KF/WEcl2uNoN
stx8wx5NYaIgqS9wnzeQ/YL23hP0b/1F4ciB7fVVy4Cvpxs0iuF/4nurx8tA74M+o7T7z1WyERU0
EMJlhA0Yk+FSJUXK3uwtL40Re3JLmxyTgqpHmz4lBopGxCJPPb/mhpqYOdnJLu2IreFY
--0000000000000812c9062f05e2cc--


Return-Path: <netdev+bounces-169744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFF5A45800
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5748D3A94D1
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 08:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0573D610D;
	Wed, 26 Feb 2025 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QleiIF9d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390FB46426
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 08:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558049; cv=none; b=XXfKnvQeZVuYWVnyG8Rj1uaSy9R/I5Ooj1FZbSXdAKFFVCwOixOomvh1PdlxwOIRtEZ7f8kYyvNMJ/PYV+eJ3eY6fu2DnuPhATFwousOmWtewp9Vd/3XNp1oQ8r0VsocUav5Ngi2Sg59SjM8zApSVRuXCWC0U5rkefIhTmlSww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558049; c=relaxed/simple;
	bh=PCUIfTuOQzwEXhO4bKy1h/wJYsSnNA3BECtECCegwWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCeX7PESlkKLPpY5RJR1/ZeHSs571NFxDNZcyno/6NeWvhjD2wmozfOvNq7IuxwJ6IqVjBe7prY2qtxjZqgKoqo8np/6IMdpMtlwpC0S5dFFsAnLECdf51t1g89r45JhQb7XKcbYuKlpuZFq60xk3GaSMvU0WMLP+/Ht+3WwbIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QleiIF9d; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8692998b124so3754084241.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 00:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740558047; x=1741162847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aQyE9qL3enxR1T/7l2BNg90bQJzoXu0zmgtKr7W2tLs=;
        b=QleiIF9dxV9ZGGhb492Wl5S0BFvx+zHUPcu57SsR+q14A9TAg3W5QhjT5vefZlnUiL
         Q/ysUzd9nXIvBEGLnNI91Yg4M4CNNWiNie2N8irXVgBsxLF4WbaPppGiPArTAyOkGhrm
         /hh8hSYxxqn8pjIt/IcUvUofKAXQSUNyt9XVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740558047; x=1741162847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQyE9qL3enxR1T/7l2BNg90bQJzoXu0zmgtKr7W2tLs=;
        b=qBHU66mKUVboxwZJRU+iQc344RnaNpNhPtMFAm3IR0ey7ylCrQGTbsCgDjZxogCJFT
         woqnwwEcNe0vlyk5nVmZ/xyQSqU1jgq4yVvOBK6LtcVxecwqS3Iyc0gbAl2ZTU/qgbwF
         53S1zJQnVZbKvDhSNUKVuz/oDXQ2xa9dUqYk3Wawp4mL/wyL4V/1IuC+0nsrulM0M3x9
         FIOEFh++rmymkKhigH+rJi3P0l/c3husJT1oghnIIawOUlvFCLVf8ULy6YWOHUsQ3SId
         Cfrlm7mDFRPDOS8rIRijeaXWK9bUydvPJo0oVWAHb0lO9A6vB+YGX/dpnA5kwlGVnmQ4
         t0sg==
X-Forwarded-Encrypted: i=1; AJvYcCUwlYDMpwYsRylDaym0anTrNjJXqHPvmmnKfBLdz9NtXJIXhhjLFn194UJTENBIsXg2prZQLKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrjnVNW9EuqXtj48LI541ZXyuLr/08K/BdYMcRV7BTXPNOo6Ko
	EN+KHRYIBNKQzmfPaRFmxXB/3v3LWpVhMZuNk9NCrYxEWssq8tUaXmBKqd5xjdFdePjg9eyJ/4b
	nxwwE6pRmPYAAKH31SUhAA0zCA4nNsbJ/0eXE
X-Gm-Gg: ASbGncubbUqzoQAR/yUEnIv87KddQxlOnC0UnmwQjrJA6QCMgzxPzjpWBX+vtEusWNY
	LHsVrk66IGC1fxxpfCSVVH5jwRrLo6pM+L7+gG2CRsGLcYTSjanLVKF3v3nSdOQdby34W2Ylg2z
	TSv/AzMYFF
X-Google-Smtp-Source: AGHT+IFY/qfuGxwpQWsvErN7VsdiLv7HCbbEf9A2HiCq8wxyOZBk3U8i2iYpkA1owSVfvSxv7YsqNstt+k9HyE2uQsQ=
X-Received: by 2002:a05:6102:5122:b0:4bb:e14a:9451 with SMTP id
 ada2fe7eead31-4bfc28ecb81mr10327170137.20.1740558047081; Wed, 26 Feb 2025
 00:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226061837.1435731-1-ap420073@gmail.com> <20250226061837.1435731-2-ap420073@gmail.com>
In-Reply-To: <20250226061837.1435731-2-ap420073@gmail.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Wed, 26 Feb 2025 13:50:34 +0530
X-Gm-Features: AQ5f1JrwL6moxI6PtKoXvU0UgfWeJcnRyoskKoNPxin3ocHkOdAN5fdaDuuQ11A
Message-ID: <CAOBf=muAGcrAf82e=V9v3vdy_P01de_1oZ-_zK00q9RXwHuC4A@mail.gmail.com>
Subject: Re: [PATCH net 1/3] eth: bnxt: fix truesize for mb-xdp-pass case
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, gospo@broadcom.com, 
	dw@davidwei.uk, horms@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000001fe7de062f074091"

--0000000000001fe7de062f074091
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 11:48=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> When mb-xdp is set and return is XDP_PASS, packet is converted from
> xdp_buff to sk_buff with xdp_update_skb_shared_info() in
> bnxt_xdp_build_skb().
> bnxt_xdp_build_skb() passes incorrect truesize argument to
> xdp_update_skb_shared_info().
> truesize is calculated as BNXT_RX_PAGE_SIZE * sinfo->nr_frags but
> sinfo->nr_frags should not be used because sinfo->nr_frags is not yet
> updated.
> so it should use num_frags instead.
>
> Splat looks like:
>  ------------[ cut here ]------------
>  WARNING: CPU: 2 PID: 0 at net/core/skbuff.c:6072 skb_try_coalesce+0x504/=
0x590
>  Modules linked in: xt_nat xt_tcpudp veth af_packet xt_conntrack nft_chai=
n_nat xt_MASQUERADE nf_conntrack_netlink xfrm_user xt_addrtype nft_coms
>  CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Not tainted 6.14.0-rc2+ #3
>  RIP: 0010:skb_try_coalesce+0x504/0x590
>  Code: 4b fd ff ff 49 8b 34 24 40 80 e6 40 0f 84 3d fd ff ff 49 8b 74 24 =
48 40 f6 c6 01 0f 84 2e fd ff ff 48 8d 4e ff e9 25 fd ff ff <0f> 0b e99
>  RSP: 0018:ffffb62c4120caa8 EFLAGS: 00010287
>  RAX: 0000000000000003 RBX: ffffb62c4120cb14 RCX: 0000000000000ec0
>  RDX: 0000000000001000 RSI: ffffa06e5d7dc000 RDI: 0000000000000003
>  RBP: ffffa06e5d7ddec0 R08: ffffa06e6120a800 R09: ffffa06e7a119900
>  R10: 0000000000002310 R11: ffffa06e5d7dcec0 R12: ffffe4360575f740
>  R13: ffffe43600000000 R14: 0000000000000002 R15: 0000000000000002
>  FS:  0000000000000000(0000) GS:ffffa0755f700000(0000) knlGS:000000000000=
0000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f147b76b0f8 CR3: 00000001615d4000 CR4: 00000000007506f0
>  PKRU: 55555554
>  Call Trace:
>   <IRQ>
>   ? __warn+0x84/0x130
>   ? skb_try_coalesce+0x504/0x590
>   ? report_bug+0x18a/0x1a0
>   ? handle_bug+0x53/0x90
>   ? exc_invalid_op+0x14/0x70
>   ? asm_exc_invalid_op+0x16/0x20
>   ? skb_try_coalesce+0x504/0x590
>   inet_frag_reasm_finish+0x11f/0x2e0
>   ip_defrag+0x37a/0x900
>   ip_local_deliver+0x51/0x120
>   ip_sublist_rcv_finish+0x64/0x70
>   ip_sublist_rcv+0x179/0x210
>   ip_list_rcv+0xf9/0x130
>
> How to reproduce:
> <Node A>
> ip link set $interface1 xdp obj xdp_pass.o
> ip link set $interface1 mtu 9000 up
> ip a a 10.0.0.1/24 dev $interface1
> <Node B>
> ip link set $interfac2 mtu 9000 up
> ip a a 10.0.0.2/24 dev $interface2
> ping 10.0.0.1 -s 65000
>
> Fixes: 1dc4c557bfed ("bnxt: adding bnxt_xdp_build_skb to build skb from m=
ultibuffer xdp_buff")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/=
ethernet/broadcom/bnxt/bnxt_xdp.c
> index e6c64e4bd66c..e9b49cb5b735 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
> @@ -476,7 +476,7 @@ bnxt_xdp_build_skb(struct bnxt *bp, struct sk_buff *s=
kb, u8 num_frags,
>         }
>         xdp_update_skb_shared_info(skb, num_frags,
>                                    sinfo->xdp_frags_size,
> -                                  BNXT_RX_PAGE_SIZE * sinfo->nr_frags,
> +                                  BNXT_RX_PAGE_SIZE * num_frags,
>                                    xdp_buff_is_frag_pfmemalloc(xdp));
>         return skb;
>  }
> --
> 2.34.1
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>

--0000000000001fe7de062f074091
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
G7cwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICgfQDsjfJsws5anMOgFjIAun66u
jnTYmDqOOc/hGxXEMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI1
MDIyNjA4MjA0N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCoHsJ4iwQRS9LUwHmCrU22XtkL4FD+jeD6Xnl1lxslfhFG
C9oAAwwhCSWFfrtTZxDO5eO9ypo07BwQ4s5dpTbsAZe6UDQr+OEdoXGttyzp6Xs8wRr58PtoZsW8
ncRvN/SvocZ5UETPdDazM7aKvtvCXTnZ0GAMM9UVLcJgp8h0S/f0v3nkjAAfn/wvUrZ5T7gB409L
oXGyztQlbbfBgTsaUhGZLp0HoNzSLiaT4uS7TRy76zfr9IEmy/+ejRUbGchhfCw8JHIZL/YNCs+2
nV+sTJQXyZK4rExb2ZVsLOC8JiO137wc4Rw0Dx+fK7fIAN0gcn4Q9tk0WIxlAK0P1G3E
--0000000000001fe7de062f074091--


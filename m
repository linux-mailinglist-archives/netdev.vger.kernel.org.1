Return-Path: <netdev+bounces-225125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FC9B8ED3E
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 04:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177E516A4E1
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 02:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D98242065;
	Mon, 22 Sep 2025 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hJrCxlSH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB324886A
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758509702; cv=none; b=o0R0d4Ylj746VWq3yD76TT3tIfNcTeYrEJJndTz6iFNXKe5GJqTa/jaHIaLpKqMmT+tHdxo0nBiEXPABdy8tnms5BiiAmgORRbgYJRgIqWcPm7wFohT7dUgwGKBK1T3cegZQ1vSg0BSLzr8ZjPob6VggmqWloiuN54gOn2Eyey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758509702; c=relaxed/simple;
	bh=JVIQzRisQAp3cTooyT2EUtim4UfQe5O9H3p9SPQ8GA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/Y3RVDAheLDop80tBQP5Freil2YTy0Bnv8MDBsBNdxs+eTGTlF7TfqlbXBP3caajuLbdRqYuz1vMVCU10bdejC8f7ezthSjrMJMbzRZW8lkxmrOJDlxStPUTSh7Yeaqy21lFj/+kekfC7IQz2iJrgkD+AiTYzZrv6GtOTt6jjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hJrCxlSH; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-751415c488cso3895087a34.1
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 19:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758509700; x=1759114500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JpiZfkMWRh5AmWc3quqQaIe+CofHHpzeuqv/crQ8sU=;
        b=X98VFw5GJIwmhCi/eLKmcR78/dDGzRpaxUwo2h8tAartEHOhbcOrI3SkSazaE/hx8U
         IslRDhc4hlSzX3RuDv2Og+a2lfaz68rAY5irsW6DZjehml5UnsH84NYjCuJFuGOPw3Ov
         Ns1PanMkrN6rV7c6fUlLyB74Ff5e3duANo0oM0gjJ9+5b7aEPSclStJRszQSR/VQFi6F
         CDruRpwUTyVV5I/1Q8zMhnkwyxLp2a41vrk7VihrPlpDNhcVjCx0nxu0RbmG1AOOj2m1
         d6uvDL7TEJWMKbhsl2stIBoJ7bQMZxb2sUw0t/Vaz8ePEdu5DKlqXT4EdB1bI3eYrnX9
         ocRg==
X-Gm-Message-State: AOJu0YxQhgzqX/KmIeh0s5nA/dem7OIROF3Ko67Qr4YkzW0XYh4BdBm3
	LeqsN7dI+AJgBTNPJG3vQpOyivrSk/Z2GwgdBkhhdENw3To3Zh7GJAAXU15ZRNGqbsyjIi0o0Yl
	UU8B77tH6oIl6NeoD8Lk0T/20TQPtyOq1pofgs4dykOGHMeSQKn+Wik9DOX318awribOlSQNSmA
	GuDcbXA9JjBC1iiq1KgyMsrroMlbKXwam2tFFQrmcBj/fycoct+kJ1AudjnTDbKAtsMf8mNMihS
	S61dONqz6kJ
X-Gm-Gg: ASbGncve1mRTonzE5dp6Y+HWXrIjiMUDQYMuCJ39Be7Erj6FhKIgS6hN1W5mDADTJ7w
	99nuWEnwxm6Se7vKFHLiToQBGarGrWa7sseyTUarc+7T7GsL4ixzg25HskiAhBfX0IKuSKtiWlM
	6lsWIu7cKwgsl6HbW6RiVhOXArJsp406umcJIVdr5DqFKVSOR2tq2cRegt8fAefBQ7T27Z+sdTk
	N1dbW0/ir+mlnyEz6e3r0pzPoFfT+okiVccrWkF92jcSYmmY98AcSVHRCBEbPjx+5Lz+bFed7ha
	wkfUQu8Z8aaSAtYjUV4FpA44RJGOLmVUoBN0miQNF9Xt/v2VEtW6delne5loM3qGmUEfHEhyeEU
	XBg2yTaTv3Yny38pBK+TwESlBXFyVDhUjW8KAGvRpKy94vQp+6ez1kfbDyNs6PQE+L9xXLFD3Bw
	U5waU=
X-Google-Smtp-Source: AGHT+IEPOpaIhtIGB+s5cjAWfOrjvkjyJk9Qd8ccypA86NuWzn8UWKjoZ5oOMs/Zo+HFKZInG2T6qBO5cE2R
X-Received: by 2002:a05:6830:700f:b0:746:123e:d96c with SMTP id 46e09a7af769-76f6eb4de0cmr5766687a34.1.1758509700556;
        Sun, 21 Sep 2025 19:55:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-63030d245dfsm5870eaf.11.2025.09.21.19.55.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Sep 2025 19:55:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-52f77af4240so841065137.0
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 19:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758509699; x=1759114499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JpiZfkMWRh5AmWc3quqQaIe+CofHHpzeuqv/crQ8sU=;
        b=hJrCxlSH2fe2MJWhnArMieNqBeN4ojjpfo4fIpzs+jkROJuOXgjLW0rTKDChKYHJYP
         aZuH+hXB/7cRkpIuaRYxIcqrpaQy43Fex9XyQROiXTAQSLQ4GRCH10YFt6M9AK5Ond1Y
         VBCwCxe3YlY/glvFqsLdgLwGu7xtvdixTVAYM=
X-Received: by 2002:a05:6102:390d:b0:598:dff4:6fa6 with SMTP id ada2fe7eead31-598e013072emr1819427137.17.1758509699369;
        Sun, 21 Sep 2025 19:54:59 -0700 (PDT)
X-Received: by 2002:a05:6102:390d:b0:598:dff4:6fa6 with SMTP id
 ada2fe7eead31-598e013072emr1819423137.17.1758509698964; Sun, 21 Sep 2025
 19:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920121157.351921-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250920121157.351921-1-alok.a.tiwari@oracle.com>
From: Somnath Kotur <somnath.kotur@broadcom.com>
Date: Mon, 22 Sep 2025 08:24:52 +0530
X-Gm-Features: AS18NWDvyTxdIGtdzNO3Wm6VbGHZqlfQdGWGihz6FTgEukuM-cNJzwCFlEAssJ8
Message-ID: <CAOBf=ms2MMk7dMiEH+V04QR_F=YusDOw6K_BH2htLODziRUKcg@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: correct offset handling for IPv6 destination address
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Sat, Sep 20, 2025 at 5:42=E2=80=AFPM Alok Tiwari <alok.a.tiwari@oracle.c=
om> wrote:
>
> In bnxt_tc_parse_pedit(), the code incorrectly writes IPv6
> destination values to the source address field (saddr) when
> processing pedit offsets within the destination address range.
>
> This patch corrects the assignment to use daddr instead of saddr,
> ensuring that pedit operations on IPv6 destination addresses are
> applied correctly.
>
> Fixes: 9b9eb518e338 ("bnxt_en: Add support for NAT(L3/L4 rewrite)")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/e=
thernet/broadcom/bnxt/bnxt_tc.c
> index d72fd248f3aa..2d66bf59cd64 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> @@ -244,7 +244,7 @@ bnxt_tc_parse_pedit(struct bnxt *bp, struct bnxt_tc_a=
ctions *actions,
>                            offset < offset_of_ip6_daddr + 16) {
>                         actions->nat.src_xlate =3D false;
>                         idx =3D (offset - offset_of_ip6_daddr) / 4;
> -                       actions->nat.l3.ipv6.saddr.s6_addr32[idx] =3D hto=
nl(val);
> +                       actions->nat.l3.ipv6.daddr.s6_addr32[idx] =3D hto=
nl(val);
>                 } else {
>                         netdev_err(bp->dev,
>                                    "%s: IPv6_hdr: Invalid pedit field\n",
> --
> 2.50.1
>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>


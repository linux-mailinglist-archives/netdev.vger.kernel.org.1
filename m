Return-Path: <netdev+bounces-177042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74865A6D7D5
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E903A188A3FE
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0480A13E898;
	Mon, 24 Mar 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMKvglPv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143A6EB7C
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809536; cv=none; b=Q5E69NC5DbzNRTM8Hjn5zFvC4C/cim4gXyLRfmU6cFsyQdfJXMOJg1msVH489vq+h7qMeC5DH9RnCOmxCd+HVEHcjAngUAiCJeZ/f6VOR8JOpwoEMEraJVkt2mQuomfHUiJOn6eQgRXFbD6rl/B9oiB9C1agx5WMpEzoZg6rtJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809536; c=relaxed/simple;
	bh=XZhmlOmzMn7L3ly3WGebbi4hGno1gDPeYtIRYaHzoLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXMjeMz/REqhvyGLp2jq75SzkgM8eYqikhClmmDnrn4aFLTmKVCbWTjEugzb+HmThuWGVyUD6UljCTArKYtIrSkvGeRZawpf2zamYJuc7ckx1yQCsMShSqQKv6wayeN1kRh/KXFAUyi0tIZEzgPhZZ6lcCSGX/ID3ztyjuitjOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BMKvglPv; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-47662449055so21024081cf.1
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742809534; x=1743414334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZhmlOmzMn7L3ly3WGebbi4hGno1gDPeYtIRYaHzoLw=;
        b=BMKvglPvd4DiqwFrTooXpriRtqNCTqJOmH/0gbWg00PAVfxmL7g5RvYca7eROkdXDB
         zVp408MxgLcoPZTT2IiH0iubucEGKJd61h7bblsnJ2QAWQSFwvAf7MbvVV/TsHH537kJ
         PVySj7w1wGFjAg7beeY1NyUeBSc6i9fnZ0sUQBjJPya2ftfYpCn2KY0KF4CftAdGuTYb
         V2RWpGA/yukYUYiEiCPCF62kW079Ht1oyGoraBn50GF+eo7y18gnEyFPm5SB14AaXpXx
         SI1ArYkmgPavL7J/cpnozelq7r4KE8lIQ+mrMKzVJvlGw2PqQHvNYYYvEzz552tv6LTf
         HUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742809534; x=1743414334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZhmlOmzMn7L3ly3WGebbi4hGno1gDPeYtIRYaHzoLw=;
        b=b5dmEyZ1Gss9aoiUWf8d+suOffMGdOz3wpdXk9xEgfz6RTekdbQWWfeIcNYx7CdRCq
         UQoeiNgTP0RvtiSLujsISvzXHXALkx3YsZFw/kGt1hfLOABvY6Yca5tidR5dbSgM8YPo
         tQPMmQq36TAUw3aRzgoTtUxBS95RWFCptv9dqqHFg/dp84cXBELwIOi4PepYWW+H50ig
         +froGp4ZYn9WOWgoAQyhee9a5XAxK244fKbhTSoajQkrmjiDnuuIgNT183jn9dSHDCEk
         uULxp3P8P7ixYXevn4GCTTif+nk+ufZkj1dG+4n9KEIB9aoDnSbZDzgDtydnSQ7E4HN0
         1d5w==
X-Gm-Message-State: AOJu0YzAtQh604eIOPUnlQz5M97En6oq/RnfLX7lx1jOv+d4PBmbn0D3
	g/bzBWacaSQEdIvdCjkkTZdTjmz8GaM1VdniCQrC7Nvsyw3GpFiqg9ZYD0aEQ8slv8/gaFlkGtb
	u1m1qA6ngEL8G3665LXoU7jlbduP0GzbP1PBW
X-Gm-Gg: ASbGnctNB8DMTCezJTZGKgYQLzodJSWXsZfX/GpmvZpT/3JbVtPDrk1cAwhVLyzfXZA
	xMzAtEqvOTuf3hb3difZGXQSSEFQzhqIVaGLGzrZLn+o1ecJI6NcupgHfjoNxvmH7uEzeDI32Br
	M48rIQ3+IiX1Hr00Ch+BgV39bdvR8=
X-Google-Smtp-Source: AGHT+IE3h56wsRsNixZnNaFs0oxKY/+1vD0VPjcwgrR5GSAL70+Cp3BU/wdN2czTGGJzKqPT2cdqRdUzxTrltbsXdbk=
X-Received: by 2002:a05:622a:2b45:b0:476:6599:dee2 with SMTP id
 d75a77b69052e-4771ddd1a3dmr225728921cf.27.1742809534028; Mon, 24 Mar 2025
 02:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ae405f98875ee87f8150c460ad162de7e466f8a7.1742494826.git.pabeni@redhat.com>
In-Reply-To: <ae405f98875ee87f8150c460ad162de7e466f8a7.1742494826.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 10:45:23 +0100
X-Gm-Features: AQ5f1JrjCSV8-MRAYsfW6Tk3ijenLHwFUM9BPMg4i_iavgFzbM-EvbyL3nC5VS0
Message-ID: <CANn89iLab0UdyMOUdfXyeSQ2pU6mxV6GSKehe6hcx3CJaRc-mg@mail.gmail.com>
Subject: Re: [PATCH net-next v4] net: introduce per netns packet chains
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, dsahern@kernel.org, kuniyu@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 7:22=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Currently network taps unbound to any interface are linked in the
> global ptype_all list, affecting the performance in all the network
> namespaces.
>
> Add per netns ptypes chains, so that in the mentioned case only
> the netns owning the packet socket(s) is affected.
>
> While at that drop the global ptype_all list: no in kernel user
> registers a tap on "any" type without specifying either the target
> device or the target namespace (and IMHO doing that would not make
> any sense).
>
> Note that this adds a conditional in the fast path (to check for
> per netns ptype_specific list) and increases the dataset size by
> a cacheline (owing the per netns lists).
>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumaze@google.com>

Thanks !


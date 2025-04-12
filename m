Return-Path: <netdev+bounces-181883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E88A86BF5
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 11:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAF61B66E8E
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E5719F12A;
	Sat, 12 Apr 2025 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGo/G8Ik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923AA33F6;
	Sat, 12 Apr 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744449790; cv=none; b=cch1jz5km5oIv5h4HdhM67/+RP1dUi84za7mVR8p61YEL2/1k6G1Em7cFuhOCJ/GM4fFXRgisGWC/dvO+AHA2KWbxg9z1+Iiy/sdUUP4avjahrv4yHdM0VIrOMSNLTpde0MBdgarJjUjVhk0Yqdqx/YM61GtHgg7chQ4QPgl0D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744449790; c=relaxed/simple;
	bh=PyHtxqdvzJpDkiGKGKlbzxVr6AnLaJq1JdOhGC2eDGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxzCLDJTgt/B/So/Vj7RcrvCBCijzWUjQmI0o/AVXtMfaneBXK+bp0FbUu7UPP6dNOsSXYe++hWWyrxEC8d2XWbuNXiW14LLHWyH3Rp/sg5SsdxmTKurA4gT/Q2bqPcMmD3nsz/GJJ+1UWs3LXxUPeBIiZ3wFY+FFBwgAlIOpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGo/G8Ik; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso28108155e9.1;
        Sat, 12 Apr 2025 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744449787; x=1745054587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vP8+nS29EeEt4QYMObmQEzs8JougkVOmBsA4oHck4vI=;
        b=VGo/G8IkHRVNRqcDqtjJnIH2zBxwUEtPtz9/wenB+Gs89/zRdCGNY7U8UXJn9Pyh1R
         JCb+maQKXVF1H/79giNmQokIWwm9LRz2Ui8deTWP95tH7UcpmB7ojnEa/+4V818sX73a
         y/1ZLpq7WeRub7f6l+pCE0s3xH8CKDEy0c5T5B9QGa2YPylRfwZgzkwymtfGuQFkLxHQ
         lngKOrWSNy+j2/di+w13j+eKt8igWjcmFSvSW0UJ6qRqbmxXwKFGYaOKLD7Qd6sl0Jyy
         1zqaNKnYUVOovmOfMuiBGFwwziUcFs4aK3NJIU2EaQy6YKnT+AUsVxTJnslitby4BUZt
         2vFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744449787; x=1745054587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vP8+nS29EeEt4QYMObmQEzs8JougkVOmBsA4oHck4vI=;
        b=o7XmZX/elIe9S37cjTf+kT4FbB2ZqBVA70qqNttbFYws/yOuu0inD9sHthedKAJ+6n
         eD8jF8uzYsjizoGEXoG2IXyHIVUhfJPgbbStJhIDgClNoti5BW6QPLWgjvbJN4JBXxxn
         xFNBTgvwY3POaQDvXi6gAUgmBzAVUR2mte1VJYrvugPi9T/CXX15a5XO6sY3NDkWqfEJ
         sPum6z4XGgsspDgpNkes7PeJhgYeY3ASupQpDR+k7SNKK8MKx5zw3PwbPE8XZmmxq4pM
         VkFXLoaRiWH51VEd6+fdad2TVZz4uRr5UUKhipDD713We2+sjC7hBhhRgMcJ8b/dOhFu
         G/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXP/XwYMM9xUdjEgTDrDju1QRD3AvthwtdUPB/MtFWPtSCSSA4XBdK9RrLMD5G68H85CdLHVuyW@vger.kernel.org, AJvYcCXrnMU5qjeIVaZvUz389cOr4ZUUULStBASBhnmU2NavRolL4KEDZCpBJcHHnbI46/4T5j5DalvV7RtLYRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJR5ow4/dGoGuFV/UxqEd1Q5JIIEzxzMnktyyE8ElhACwb4rHf
	hxmnwDZA0LKhFQrvHshG+IvSK0BWGxIVX5LrDzdCgDj4f2H5zqkU
X-Gm-Gg: ASbGncvG9i80GR5XYhtnV8PyBwGOP6jlo5UCA2k40R8g1VYkb6XVbakHPAdAk6QQdVu
	JaWQeRhqfsAgmx4PB4lQYqgPgb39d0HyRPOu71LJ7OFgNa/R35rcXgIpvbzQhKtT1Rr9fL4Yzzf
	PhW+zFo7a/oUYCVeo2XmQZaBx63bsJ4Dl+RWvgCSCT72nxMjXV9u8B/Zqqrc7h2j5b2QmDvn1dp
	xbWq34CQakcwekpIQyXx08BMJfjdpbbMBHbE0WrbQ0/Pyy4XeKrwY82IacXWRBEEQB6C3VvDaJX
	jGOOYhpdsrWLJfrfDnpm1hnJzbbHL5H+Z88XXCb0K7ro0NVtekK2erelS5lV3rc9c/tPcwIGbGD
	b4X4=
X-Google-Smtp-Source: AGHT+IEdvyQBBmM+g9GNjxWlarB7rYN6lH8hVFAsGG/oIntQEo2K2905CeEol3l2b14ckD4up/jsKw==
X-Received: by 2002:a05:600c:1d93:b0:43c:e8a5:87a with SMTP id 5b1f17b1804b1-43f3a95bcfbmr61779245e9.16.1744449786503;
        Sat, 12 Apr 2025 02:23:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c7a68sm108921695e9.19.2025.04.12.02.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Apr 2025 02:23:05 -0700 (PDT)
Date: Sat, 12 Apr 2025 10:23:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paul Fertser <fercerpav@gmail.com>
Cc: kalavakunta.hari.prasad@gmail.com, sam@mendozajonas.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, npeacock@meta.com, akozlov@meta.com,
 hkalavakunta@meta.com
Subject: Re: [PATCH net-next v2] net: ncsi: Fix GCPS 64-bit member variables
Message-ID: <20250412102304.3f74738c@pumpkin>
In-Reply-To: <Z/eiki2mlBiAeBrc@home.paul.comp>
References: <20250410012309.1343-1-kalavakunta.hari.prasad@gmail.com>
	<Z/eiki2mlBiAeBrc@home.paul.comp>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 13:50:58 +0300
Paul Fertser <fercerpav@gmail.com> wrote:

> Hello Hari,
> 
> Thank you for the patch, it looks really clean. However I have one
> more question now.
> 
> On Wed, Apr 09, 2025 at 06:23:08PM -0700, kalavakunta.hari.prasad@gmail.com wrote:
> > @@ -290,11 +289,11 @@ struct ncsi_rsp_gcps_pkt {
> >  	__be32                  tx_1023_frames; /* Tx 512-1023 bytes frames   */
> >  	__be32                  tx_1522_frames; /* Tx 1024-1522 bytes frames  */
> >  	__be32                  tx_9022_frames; /* Tx 1523-9022 bytes frames  */
> > -	__be32                  rx_valid_bytes; /* Rx valid bytes             */
> > +	__be64                  rx_valid_bytes; /* Rx valid bytes             */
> >  	__be32                  rx_runt_pkts;   /* Rx error runt packets      */
> >  	__be32                  rx_jabber_pkts; /* Rx error jabber packets    */
> >  	__be32                  checksum;       /* Checksum                   */
> > -};
> > +}  __packed __aligned(4);  
> 
> This made me check the Specification and indeed somehow it happened
> that they have forgotten to ensure natural alignment for 64-bit fields
> (at least they cared enough to do it for 32-bit values). [0] is the
> relevant read.
> 
> > +	ncs->hnc_cnt            = be64_to_cpu(rsp->cnt);  

Doesn't look related to the structure above.

> 
> This means that while it works fine on common BMCs now (since they run
> in 32-bit mode) the access will be trappped as unaligned on 64-bit
> Arms which one day will be common (Aspeed AST2700, Nuvoton NPCM8XX).
> 
> So I guess you should be doing `be64_to_cpup(&rsp->cnt)` there.

That is is the one that fails - the compiler is likely to warn about
taking the address of a member of a packed structure.

If the compiler knows the value might be misaligned (eg if the structure
is __packed) then it will do multiple reads and shifts.

IIRC it is enough to mark the member rx_valid_bytes __packed.
That removes the padding before it and the compiler will then assume
it is 4-byte aligned.

	David

> 
> [0] https://www.catb.org/esr/structure-packing/
> 



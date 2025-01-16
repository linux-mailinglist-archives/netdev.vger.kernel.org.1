Return-Path: <netdev+bounces-158805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A00AA13516
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05B018826FC
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 08:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8123F1D5ACD;
	Thu, 16 Jan 2025 08:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWTtNFhH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404619343E
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737015270; cv=none; b=TzJq1C1ITWYl/WQWp0kgTjpaddPY/PO2pZ7UKy08bA0JrTHB67GEgwjT+2kmKmuFfZIeXZYuI1EFUQTkoCOfbPRo6VR63VsHVOACdxj/X/dRWjEWoijpUOi4SpBdEPutkZ4g+ND2h7mNrxAwXG+Y8Cz1AzCt06YnRYmgLUVZJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737015270; c=relaxed/simple;
	bh=fort1JpzFCk9aJtnmJGBE2dcNxsiha4izVe2Fx5p3d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7/g22w4Bk+G/LD26ElHc8dXK8efh30wvlONngXUR54Ov+dCblivYzGw0NskCmHB+4tTkbUkz3qiErFXbbxV0SiaCpkCdX8sh+P7OO+WuLRAb3rN7v1yA9suge4FqWgtN3lZ146MdSP5WkvUZbAcmSyXBIHhzbOlsD+xGbh/KXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWTtNFhH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737015267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERbJSuqsAOXaaj6eB/CkwpIU16l9eEjJ8jUx0oPfO3Y=;
	b=bWTtNFhHnZgPQ8ChO9uBkJDmPj3E8o9kouxK1STRX7vPw6BusCXPEXwuZk/7pC8g18SBH2
	O2a5nD3YXlcv6EEuMAx/rEaH22mhTOIN7vIzUDap+NRFHCGXfioLVBBzTUPBAWrl2AkUMP
	Oe0mLNAikgqK7iEVU2YkuaJ9XhxliKs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-HvLV4BbOMz-f9H1pVE6mpA-1; Thu, 16 Jan 2025 03:14:25 -0500
X-MC-Unique: HvLV4BbOMz-f9H1pVE6mpA-1
X-Mimecast-MFC-AGG-ID: HvLV4BbOMz-f9H1pVE6mpA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38a684a096eso261222f8f.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 00:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737015264; x=1737620064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERbJSuqsAOXaaj6eB/CkwpIU16l9eEjJ8jUx0oPfO3Y=;
        b=gXz15CJrRrD6Yyc+TO9QXQLHoMwaGLwgSoxrCTiXzREuXt9+LIBk2ZdUoZ/sdQkQhT
         W8I9ndiLVA05C3HZd3DAQjS/s/eKiH47LFTpSBL5n/ZyJzo5hRbhI3kZmPa0DddpgHJ9
         G27nHk6zaE4Z/CRvkbCf6p9jr1SHaPUcPb9XfiGoo8gkj5VGaLac4tNooBvIPEq/9lgs
         6ZkAOcZ7mnhxcrZsM2Mv9vlZEzUhizi6jB+LGLgirjpm+0EFhOCoNZx9Yc/GRk6XzqrP
         Bv1z1X1j5UrqIcg2eyN84jZtFblIjuNB+w15xoJNpV58bXohUZrIiiNXKcdPjBEWHiMQ
         9pfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOeznBAdoCu2Am+Mf2VVDa4QGE+ZmTNvBesYcHWUoMY33GRV0lhFJAyhfPwr9IZuVUC/oYMbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmUvq8YUgRCNz76SDjKoTpzIEwgwjOMsT2aSVL31Tf6qKV+R2J
	//zMAhMwMJMxmiqXzRQddcMgqzGdcTejAFD/83psOMgyWIqBkuMMYT/BUJ/PC/Zfz7ahLr1p5VQ
	mDS/Ah4jcU71Tz9rCaSbyrolIJfRzULeRy4obvUnCFgg6pnc2fkwJFw==
X-Gm-Gg: ASbGncvNDZQuZhyIFCdieD3Wq+PQasr1HcLmv9uizakSE1UKkqJXIyeuzrMAzyWkWtm
	6hCfbYFETXzAE2W8zWQAiFCSzjvKwf5Y4tBbdARACOjc0AofX/tQqg5NdUtlWKAw34IH1t8PMKL
	5/VKkmeEhQL9Pw0hFLHdlZmV+VgMiHnOqK8QYa85RRWRx8HlYZWaWvpQGX2MzJ4XLES25XLuGp3
	BUGqGsrA9xETkax0ORrx3v9Kill3sVs/zJL1NaUz8L1fBMe/Ytf
X-Received: by 2002:a05:6000:2ad:b0:385:f5c4:b30d with SMTP id ffacd0b85a97d-38a8730dd17mr7142041f8f.39.1737015263736;
        Thu, 16 Jan 2025 00:14:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVuBvar1zeSUO961UzYaw/R6lkjncjPewk3IhqyjOPRMXTTO5yWHL+JU+PeFfMlECdyG2zMA==
X-Received: by 2002:a05:6000:2ad:b0:385:f5c4:b30d with SMTP id ffacd0b85a97d-38a8730dd17mr7141999f8f.39.1737015263364;
        Thu, 16 Jan 2025 00:14:23 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0bdsm19629001f8f.3.2025.01.16.00.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 00:14:22 -0800 (PST)
Date: Thu, 16 Jan 2025 03:14:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH net v3 0/9] tun: Unify vnet implementation
Message-ID: <20250116031331-mutt-send-email-mst@kernel.org>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>

On Thu, Jan 16, 2025 at 05:08:03PM +0900, Akihiko Odaki wrote:
> When I implemented virtio's hash-related features to tun/tap [1],
> I found tun/tap does not fill the entire region reserved for the virtio
> header, leaving some uninitialized hole in the middle of the buffer
> after read()/recvmesg().
> 
> This series fills the uninitialized hole. More concretely, the
> num_buffers field will be initialized with 1, and the other fields will
> be inialized with 0. Setting the num_buffers field to 1 is mandated by
> virtio 1.0 [2].
> 
> The change to virtio header is preceded by another change that refactors
> tun and tap to unify their virtio-related code.
> 
> [1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
> [2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Will review. But this does not look like net material to me.
Not really a bugfix. More like net-next.

> ---
> Changes in v3:
> - Dropped changes to fill the vnet header.
> - Splitted patch "tun: Unify vnet implementation".
> - Reverted spurious changes in patch "tun: Unify vnet implementation".
> - Merged tun_vnet.c into TAP.
> - Link to v2: https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com
> 
> Changes in v2:
> - Fixed num_buffers endian.
> - Link to v1: https://lore.kernel.org/r/20250108-tun-v1-0-67d784b34374@daynix.com
> 
> ---
> Akihiko Odaki (9):
>       tun: Refactor CONFIG_TUN_VNET_CROSS_LE
>       tun: Avoid double-tracking iov_iter length changes
>       tun: Keep hdr_len in tun_get_user()
>       tun: Decouple vnet from tun_struct
>       tun: Decouple vnet handling
>       tun: Extract the vnet handling code
>       tap: Avoid double-tracking iov_iter length changes
>       tap: Keep hdr_len in tap_get_user()
>       tap: Use tun's vnet-related code
> 
>  MAINTAINERS            |   2 +-
>  drivers/net/Kconfig    |   1 +
>  drivers/net/Makefile   |   3 +-
>  drivers/net/tap.c      | 172 ++++++------------------------------------
>  drivers/net/tun.c      | 200 +++++++------------------------------------------
>  drivers/net/tun_vnet.c | 180 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun_vnet.h |  25 +++++++
>  7 files changed, 260 insertions(+), 323 deletions(-)
> ---
> base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
> change-id: 20241230-tun-66e10a49b0c7
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>



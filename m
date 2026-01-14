Return-Path: <netdev+bounces-249941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FD5D213F5
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 21:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 248EF301FF45
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 20:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB153559FB;
	Wed, 14 Jan 2026 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDtmXTIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD5352C41
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424238; cv=none; b=ozfcFbNfcN7fU0+aMvIKGvEaygJTZTkgjdc2pMyjL8k+9LJejDbe+6Fc5ZMUC1E7dQziLY9/loDpyK7IH+1A9K79ijDKeyXq9C2l/WC5VLrtBHKvHxmnpfG7N+VxWuWeExpxzkO2sX8Z32eYWKwR2yEZ2oVrcN5X5wFhnA9WOJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424238; c=relaxed/simple;
	bh=6lgqOxbPHNOArWY45nHfTm2tPRqlerXXqceazU8APT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyYHiL/X90QSCQynJi6JMsKGHHtPMrBCd7xO8LV/sv4HuBIkUbORq0N43qjxSAHY00fiIUiHVa91ABYNYQ8LBLVL+m97PfArbYfUC4h/3WTy9v3TtKm6uoZahdATVFrrdzjxbMTdmUurN2SxoZf3FqOMXJvtlg6NG7hv9SS8SUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDtmXTIp; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12336f33098so210782c88.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 12:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768424237; x=1769029037; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z5PeObjK+JU3X3/JKuMBe+NM0vlnH+5ojUyknKOr5kc=;
        b=FDtmXTIpC31GPVQ2m+9+HvTmwTa5mn9kgkanApcRxv6wxepam9nt37W/rZ+ebbK5g8
         ZWCUSgnSzmQFa3vtVy3zwBTN6eZxzjwWYOR0mn44DrTY7APATWU8jFBPGzVvbbn5n9WA
         1cV+oySYapsPWG+X1bpajS3gmDdL7bcgW9FV9is9GDV8QTF4u+CdTdLRpOrMjUVZFIie
         aw27vdtjsQ82zb831pwNW9cx1XlInRgm8+yziQyjo+OazbFWupnEXUwvgf41w32cj1CA
         xLmYn2j6uMNEARnYKHtM83a4xnNBoFfVUv4bQPCqwESFQi85cpkSAds949Vanx0Ax83q
         bMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768424237; x=1769029037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5PeObjK+JU3X3/JKuMBe+NM0vlnH+5ojUyknKOr5kc=;
        b=GKG8yDfxhikYOt0j7ezYztdXk+GWSPsMqB0YKJ3MmH3wQb7B2Tw8V/F7DcA8Qu6+8A
         rofsdSUR81KvejR+5jx8aFSy7mB3Lr4z7e76HQX4xykS6YT+gV08kKs+P0ZPiOo+2vLh
         yad8734awp9UI1zVwCPzQzh5r0QE6fQPAP/EA4VlGdZGB44BYmBXwQgNlj0xnkYwaaIa
         qwBb/sgCMfqIs32+j14Obni+LlK4rqUXcNBAljf8Gso8Xvx1P9XZGv1Ij1wgAIX5vZRQ
         lwU1q2ojclBPmQwAJ6XJ1iqUxfgXwZbE6ta20dIpi93nCc4h0x6mCT3vfeqeQKv9SrZ8
         bIkg==
X-Forwarded-Encrypted: i=1; AJvYcCUAPtlxkk1ftIVGUq9AcM4hLQP+sP4QxIvHWjh+2i+CCwLqWz0IOUIbktKP77/LQmSbILBlpT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQQt0eNgypduC8gRNr9ColkqyGwr7Vrq9DdRxy0HU7bx2COCaE
	eFvX661QWD7IfwzfJATv+pNtrtegLX/TTW3yGUW3M41N9ysmK0I0me0=
X-Gm-Gg: AY/fxX7kq7CGjSCbxSgXQ2Ik15naZoefXLySFY2s4XwaRqYPtFiVaEG26SPdbWrt5hn
	2HGHXDIZpxIp7CtoegV76TZe4t3eVXC7VGGGONq+jsPk8IATqeFcQpAP8mWM3hlihex45BOqjUY
	JF+CYvJwSw2DGGm5eDXpI+CYzTrGMPNGtnQSMJ72YAZZEtDAv9bUaVL03lqUnUh53yivYu7yEgK
	GhVPj8SpIa3WK1DqmqbyFciJZHDUOIzuDRF0xgyTFU39osMvs+TQ/tzPxHlg4DW/gK+AtbUP32n
	48lwbUs2Hkj+bOL4WEkyWa3ZAWFSdNKP5WSS0FIo4AsxzfU3vEUWVdpRU99/+JRWyzk1DcoI8rC
	Qgo4RvnMiXuAwdJuNQsGCbUOrQiSoqLyM6cHof/SYEEuGVZhFka756FPzIrQ1FAyHUYC8/ienkg
	ZDAjhvbvYqKLHZIvsMmbWz6BOwlaeqY3uZId0y1s4lccSYJ9FzZOz8+PQOsNEZJHNynbw4hLRnH
	PW3Pw==
X-Received: by 2002:a05:7300:1484:b0:2ae:5d3b:e1c6 with SMTP id 5a478bee46e88-2b48706e7b7mr5125641eec.21.1768424236381;
        Wed, 14 Jan 2026 12:57:16 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673bc0sm21277584eec.5.2026.01.14.12.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 12:57:16 -0800 (PST)
Date: Wed, 14 Jan 2026 12:57:15 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6 2/2] xsk: move cq_cached_prod_lock to avoid
 touching a cacheline in sending path
Message-ID: <aWgDK4Zq7NShgql5@mini-arch>
References: <20260104012125.44003-1-kerneljasonxing@gmail.com>
 <20260104012125.44003-3-kerneljasonxing@gmail.com>
 <CAL+tcoDgNWBehTrtYhhdu7qBRkNLNH4FJV5T0an0tmLP+yvtqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDgNWBehTrtYhhdu7qBRkNLNH4FJV5T0an0tmLP+yvtqQ@mail.gmail.com>

On 01/13, Jason Xing wrote:
> On Sun, Jan 4, 2026 at 9:21 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > We (Paolo and I) noticed that in the sending path touching an extra
> > cacheline due to cq_cached_prod_lock will impact the performance. After
> > moving the lock from struct xsk_buff_pool to struct xsk_queue, the
> > performance is increased by ~5% which can be observed by xdpsock.
> >
> > An alternative approach [1] can be using atomic_try_cmpxchg() to have the
> > same effect. But unfortunately I don't have evident performance numbers to
> > prove the atomic approach is better than the current patch. The advantage
> > is to save the contention time among multiple xsks sharing the same pool
> > while the disadvantage is losing good maintenance. The full discussion can
> > be found at the following link.
> >
> > [1]: https://lore.kernel.org/all/20251128134601.54678-1-kerneljasonxing@gmail.com/
> >
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> 
> Hi Magnus, Maciej and Stanislav,
> 
> Any feedback on the whole series?

LGTM, thanks! (I'm gonna be a bit slow on the mailing list in Jan/Feb)


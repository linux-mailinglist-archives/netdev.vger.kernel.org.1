Return-Path: <netdev+bounces-85298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0689A14F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 17:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05471F21BD4
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31EF16F8FA;
	Fri,  5 Apr 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kh5ni2hu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93E16F8F7
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712331293; cv=none; b=FNe9nkecPAr2YDYJrILNEy5nyBVFzU5VvGRRzrfVFseg+xsz/95YAFg3Fnvf2ZzHJ52jcCMkUR77NmeHqvex90Y0LBlM9/cYVG4et8pXNIIpt76kgdCDAjyf1fk4JwcNenNQXyFDuX1DrsA0LPBdRKGiimIzjh542KJwMmkcQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712331293; c=relaxed/simple;
	bh=tm1FnFlIHjwQKAZYCNpn8MgWKoAZAbkaLcJU4/RJ2pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2+QsoxB/DJG/Tjfkq//QnnPfH5HGjXevHbnmlWcU6v+eYnjhDlAC3bb464cNT+69rDnliqbSieOnwbSKUF/+9RcTdXf6hkVuNkmNCFlRLhVkdUT9oAUHm6cDyBpIDDjSsBWd51AcGdNZq0eboN5On/oakNNI2cQrtUTMLLdGdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kh5ni2hu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6eaf9565e6bso1708563b3a.2
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 08:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712331291; x=1712936091; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqYCBovgZCgYQMMpGTDHDkDmt+TtdcySI9bw7EEQC9Y=;
        b=kh5ni2huSjazyHsb8WDKVG7odAX15BgJmorIx+ucyaAZaDzsIlJRkVox79/g1l4rd6
         5xr7GC3s9ek+8cMsYrnFWRQ6caWla5x/ChPR7vcLg+oqiecT/JPmCIc145h/mK/PcjM5
         jEIy8c+B1k+CkVx2JBdtfvUiIHxkZo339FxjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712331291; x=1712936091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqYCBovgZCgYQMMpGTDHDkDmt+TtdcySI9bw7EEQC9Y=;
        b=TpOATIRegdaCcQVG3Ws37PrpbWsxMzIMRE5HY/EltBt/dZFSe73ceqIk+h5xQMLlEB
         uMsXK3lxXyXI9sNFrPmJpju7MzMYzOqsxQ7Jpj7WPPErbnFb6B6rc8K0xoyPi8D4qvtO
         i2fhA6VFoYuqxlyhd/EPhIYxNsLxCOpconsMa56d0MClKIiuMF6PniBjC3TChwOB/S64
         M4B1vyvTbiEsBQ0NCqs8NspWTHZa78N6OjxqokLblV5+pNToRQsvViXaqomTbt0i0ra1
         /RkRe4hSIEvTERili5SBsaZB+R6XnSHtmiUQYY9ItiaaLRvgOQfQJ3c2yOSXxb/sEzLM
         iCCg==
X-Forwarded-Encrypted: i=1; AJvYcCWn2D6JquKS8M1v5cQQNa3qutD9pXFPYpPY0UvBwrumKmClAmTSQuQRZmEi/cII5Y3+p4xfch5s87P5rj6gi0hyMbNzNO0S
X-Gm-Message-State: AOJu0YyZEKBrf+aZt2tPd3i9enrhCPRcHK7BpsN5EnMLR5RjuGI08DvW
	SNIpAF17sdHE2ydjaeBMRH7bMee2znjzPdSUJ9TGOsVgPaux0XYVGP2oxhhySQ==
X-Google-Smtp-Source: AGHT+IFB3TlYkfsu6Id9/C8DZ9NUwWsbM0meKnkYL2uaQl6aHtcqFK4FGDHZdPPlkE25MS/v7ua9sg==
X-Received: by 2002:a05:6a20:970c:b0:1a3:e25f:3c17 with SMTP id hr12-20020a056a20970c00b001a3e25f3c17mr1887382pzc.29.1712331291411;
        Fri, 05 Apr 2024 08:34:51 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b29-20020a63715d000000b005dc507e8d13sm1567923pgn.91.2024.04.05.08.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:34:50 -0700 (PDT)
Date: Fri, 5 Apr 2024 08:34:50 -0700
From: Kees Cook <keescook@chromium.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next] af_packet: avoid a false positive warning in
 packet_setsockopt()
Message-ID: <202404050834.2D7685267@keescook>
References: <20240405114939.188821-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405114939.188821-1-edumazet@google.com>

On Fri, Apr 05, 2024 at 11:49:39AM +0000, Eric Dumazet wrote:
> Although the code is correct, the following line
> 
> 	copy_from_sockptr(&req_u.req, optval, len));
> 
> triggers this warning :
> 
> memcpy: detected field-spanning write (size 28) of single field "dst" at include/linux/sockptr.h:49 (size 16)
> 
> Refactor the code to be more explicit.
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Looks good; thanks for making this more clear for the compiler. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook


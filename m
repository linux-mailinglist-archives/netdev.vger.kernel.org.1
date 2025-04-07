Return-Path: <netdev+bounces-179977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B825A7F058
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC6C17B184
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E153B21B9D6;
	Mon,  7 Apr 2025 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp+Dhi54"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1593AC1C
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744065147; cv=none; b=WCFGmQJabwond+EeL4imACURo5kcQqMg8bZhr151N2AXclurFubgNEw1vvFzUxRVo+31MWH5TbvSvMRnUVY7VPo7gvv+N/cYZCMBOKZsuUh6MfXzo+Hpd9430Iv331DIJjkbSmzUGmu0yA5rLZU9AvLEC7S004gzM0dB5HewKLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744065147; c=relaxed/simple;
	bh=dff8/DgyWL8n71ZrwOFoqtAzyP781CkOWr630Rdrf+M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jYoEvmLQU6ipMrWD103HRwi+gLqE3AajuvFXq46vzoxAmvaN+fn4wFdoRtE455gWFdS/uLMFcJ1mbzmsq5KD4x/tqB/0eaoYDY18yD64Qn7AeoDIxVWznD6WAkUv+4xdzf770hHD5fxI/wndoDXvupGojqLYPSreuZ3xyoVIyaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wp+Dhi54; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8efefec89so42984886d6.3
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744065145; x=1744669945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy0278xDgmH9LQb2u9BCt5QH3O7CfwboZjgwinggOPY=;
        b=Wp+Dhi54ueawQ7qYG9FNQsXkFXC6ko/vP8h+5p00NNPO1NL3l72YqqkjFDMekeEjma
         bPtvb3wUPZ6QzxLZqZFgev+LYRNLTB25exuYZ2hLTqpwe9X6GkGm3PdaR8qd6iVUI1g1
         iYs7NKmRzLzGJo0K4+VycYrIPc0RDNKN/3aITeeRmczNdXc2BKFy1bopMxDv5eNswe5y
         uOPcRJB5MCkiyV8ThAlEFbUNlS3hO6WkBLWhyKznGSOU/aY37iKE1Qm/C0MfdHdcEOhF
         wvexGHK/XqdoduaHcIuMm/p65iFGFpI8ArtEgsCg3o9HZ8VktwarX4w7GpbNLXbTt6bt
         uUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744065145; x=1744669945;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zy0278xDgmH9LQb2u9BCt5QH3O7CfwboZjgwinggOPY=;
        b=UajbaxAqXe5xejp5lphJ0MA2Kj/+QAjGZmKoIBSYpO1r0L4uTv6GFBc5FlsmP0WD9Z
         75qPnw2lYOKVu0fDMAHDJXFVpWRmEMJ0tMfOFGJwkPeQlxQGTUkDS7cYtnh+l8KdSv+9
         8T8teQi9QbCCL9E11FWcswldAUx+63s6FYILEkb48WZXX8sHEtct+nS0qQPtCDqVNnxA
         LA73A4HRwbCjUCadDe93VwSnZABL1sJY8PQ7hiJDs5wajE/+zef5miGysrhVA/P1Idri
         sIsfjZvQWLOXR94fQFLU06RNtQl/8pOtGfUO9N6/miu17oUYJ/MHC8KjDSotNOMgNkAe
         6CCw==
X-Forwarded-Encrypted: i=1; AJvYcCVPd2BNRGXdllWgAiqllTudulz+6devrbonZP7H01wYrfouYDannMz2rOSe6rHT576akwQKuKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd7EcGWSPE7GjE27Lzkl7IXM1Q3a2WmhFEyByQi0We9Xxe4BJS
	HurzfE3OnAMIsslEnZUMOSPFI+U4uGMrDrkLUkcsiOVN6lpaRwHjDPaj/A==
X-Gm-Gg: ASbGncviuKKv3OG1ItShn+VQ8LB7ajbmsShfTArvA5YJgb7Y5XO9NZ3ylDIkfQ6Pm5S
	CzlOM2ENS9d1aJO22tZsrF6VqPFgzBY7WIEMAmZUbrSojTZckomZlXSPekdtwNqoOPZsNPnQdZB
	3Lu2iJJOU15PGCmc3jXVk0qJOHXhmagwWoNVEHKN5397gTIBUb9M0iQBofc0f0hwCb0PPaXi4nZ
	dg0qqezo5k8UtuqAsdz/R9oNgUSI7dr6tOT9mV9JS1HWnSAXWBOpzPyHexCsfZbvG88kU1j6Sg/
	gDX5IfHll2UGZ3I1psk3k6PeO6s6LguwrpqC+O8wBAVDRVYSiZitWZ2yEHeiSN7ga+lMOHZzIjq
	CNZmcr47liu98pFaf+pIr/A==
X-Google-Smtp-Source: AGHT+IHOjRBnXOtxZBnd/tXOryUvCqfpuOKFQN57bEoKfg4P+4+FYmu6rw/ImfChI0k3tD7d8vBMSQ==
X-Received: by 2002:a05:6214:1247:b0:6ed:22ef:19b6 with SMTP id 6a1803df08f44-6f00dea301dmr213791086d6.14.1744065145222;
        Mon, 07 Apr 2025 15:32:25 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f16535bsm64603136d6.123.2025.04.07.15.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 15:32:24 -0700 (PDT)
Date: Mon, 07 Apr 2025 18:32:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>
Message-ID: <67f452784b16c_3bfc832946d@willemb.c.googlers.com.notmuch>
In-Reply-To: <53d156cdfddcc9678449e873cc83e68fa1582653.1744040675.git.pabeni@redhat.com>
References: <cover.1744040675.git.pabeni@redhat.com>
 <53d156cdfddcc9678449e873cc83e68fa1582653.1744040675.git.pabeni@redhat.com>
Subject: Re: [PATCH net-next v5 2/2] udp_tunnel: use static call for GRO hooks
 when  possible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> It's quite common to have a single UDP tunnel type active in the
> whole system. In such a case we can replace the indirect call for
> the UDP tunnel GRO callback with a static call.
> 
> Add the related accounting in the control path and switch to static
> call when possible. To keep the code simple use a static array for
> the registered tunnel types, and size such array based on the kernel
> config.
> 
> Note that there are valid kernel configurations leading to
> UDP_MAX_TUNNEL_TYPES == 0 even with IS_ENABLED(CONFIG_NET_UDP_TUNNEL),
> Explicitly skip the accounting in such a case, to avoid compile warning
> when accessing "udp_tunnel_gro_types".
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


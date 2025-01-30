Return-Path: <netdev+bounces-161646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C8A22DFF
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 14:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C22D1883771
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2C01E5729;
	Thu, 30 Jan 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFY1Onie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D41B1E47C8;
	Thu, 30 Jan 2025 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738244688; cv=none; b=fk2giDcsn0xMKWUWHkZLpqnVg35Ph3ykMLdTMCGtnw3n/a6qyt9twIBv5Xp0xXed6GW8PsaV5uCa0UzDATvuwQEUtCBWPNWPlbBGid+hIM1vHXnYwULrFEWiQIgZb1dQ0+IpoERbqV7lbEMn7ZRQa0lLopEK+hu/ZUvRqCkNneU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738244688; c=relaxed/simple;
	bh=Zoo1lecfhZxxU+f9T/aEumCtGAS46u8d15EzmjphLKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m21E4vLi3bZ8A3an3fsF6s1Sd77pX73Ip6qm91djdT7oMfSpMY7AbAoYTsVAJORf0erdSzSQ4rXd85ZmOgjASo7noam+y1WZVfpfXZiFg+xsL3GrePId1/+ckrS0T0b1fFSFt+wqbqIYZ2EECWJBWSuBJ09aYSqhpO4/OZ//Q8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFY1Onie; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so186540866b.3;
        Thu, 30 Jan 2025 05:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738244685; x=1738849485; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LoyBCNpacaLR1y8uMZvCscmsTHlmutDhN94aZ0BhOz8=;
        b=FFY1OnieigESNeapkY1MFVjt3GG/Y4x0Rwfimpv3xhJold8gjHuk//VsnqVG1MHUE2
         SCKiILbfZ5OkMn1lx5s9LuYOtL+VIdE+tuH8kvUaZX/kdtqJICqnLeV3KqPzz019yIYb
         /TdV/RFIMYuJK+f8JTS2RFqVHZzSM/HMtVchJ04o7HON9Xka5wMQniJD300cL/qV8vdU
         mJ5mo4CKbOYes+DAgs0di41XQVwCTmOnQ3a0G45I67fexIjQiY2pNeX1NwTfSOe9lAi8
         Z9E1fapgyKjNjb6fo6GuNTOhHtXIyeiInkbsuTOHxMLELPRiFITGqWSJU6J113p02ekN
         SbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738244685; x=1738849485;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoyBCNpacaLR1y8uMZvCscmsTHlmutDhN94aZ0BhOz8=;
        b=pbrueyflxXM8UyhFmw0XhaOwHX4tPxscOZX4zekxOazAJassZQSgko0uv3gfaEc/UX
         hpeRulxi8XwnZXC3wK3UFBDjcs89CNoA8hGUlMOmDU8Ud9KheHyA1sqGEnzoD744EvPG
         n5MrjC0tTyE6uRE+jVuhSw+760eJeMd2ZIns4Fy+huoLOtVc0Rc/qCGNsw+HDHxakAmX
         uk2dughiEXzTM3zVPFvAPWXoP6d9N/5dFoPcca/pceKGoFkuKjqznWOapVjbMuQtTmAZ
         iiSPVRTbgrUEj+Y4yjh+vmL5KyRdHe8HiLvfFY+vL2E9ky+iIkASxqiumMoW0tMabiHu
         hAUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl81tgj6ZoCKG9YYAz3+cT0cjUoKT1y6d3DuYNcTBsf3wiX3igIuM5W5WBeE3tkg13xDdQFxdUS4R6oyVQ@vger.kernel.org, AJvYcCX5HlB9/Ot0K5MygRECowDztIB9rp7B4uyWFZwk2mUYTRwcAg63u/UoqMA0wZSzXZfjXz8cOrVMlWVuBNotqdA=@vger.kernel.org, AJvYcCXeyqN9Ymew+VDkoNVQabyLVKwobZsNiV3UnWtwEzGg+lhtA9OgvP/0Hl+00EEBJRCrFymHuefK@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9rARsYwE+j7ayF29hsduKjvT2uTwLv/sQD5yNmU2sWm9fJR2b
	Cx7ypmVZ2gsxH1g8P+j9lTqcb6x8UiENPnDwxFOH9Ha/uQjbocM=
X-Gm-Gg: ASbGncv6EF/gBf0jzst0dfaimJ4p8U9xNWlWQ8CllmL119vk0Y2Cc8kLYExJ1xKDTnU
	bMvXzAoUMXvQLtOsAwsi9n1x96OaNzyCDdITOlupYvEc/oo6DuDleRUkVO2oD6F4xDF7muAUkXR
	K3ONi+SswDzx/MLlQhfWyBfbRQSXFzUJ+2zWMYWQO314YfRPbQmaOQBCfMipgeTkZAAE7wwDk3P
	Mxg0XxZYYcs10jRC5t7eVRbT1Z0zbe0wG4FF2xHUAaR2yjtgFOEFYiEwOzsCGw3oxqUOrdXSmWL
	vA==
X-Google-Smtp-Source: AGHT+IFuQn+B8fj12pxE0PfL3E5gFfWpeVUKxRinZMiH9LzfBPmTNaSIGfoXgI38Wep2ZZ4q38CiRg==
X-Received: by 2002:a17:907:7f29:b0:aaf:73e4:e872 with SMTP id a640c23a62f3a-ab6cfcc5171mr714662766b.3.1738244685038;
        Thu, 30 Jan 2025 05:44:45 -0800 (PST)
Received: from p183 ([46.53.253.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47f18e8sm122099166b.76.2025.01.30.05.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 05:44:44 -0800 (PST)
Date: Thu, 30 Jan 2025 16:44:42 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: less size_t please (was Re: [PATCH net] xfrm: fix integer overflow
 in xfrm_replay_state_esn_len())
Message-ID: <03997448-cd88-4b80-ab85-fe1100203339@p183>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> -static inline unsigned int xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
> +static inline size_t xfrm_replay_state_esn_len(struct xfrm_replay_state_esn *replay_esn)
>  {
> -	return sizeof(*replay_esn) + replay_esn->bmp_len * sizeof(__u32);
> +	return size_add(sizeof(*replay_esn), size_mul(replay_esn->bmp_len, sizeof(__u32)));

Please don't do this.

You can (and should!) make calculations and check for overflow at the
same time. It's very efficient.

> 1) Use size_add() and size_mul().  This change is necessary for 32bit systems.

This bloats code on 32-bit.

	int len;
	if (__builtin_mul_overflow(replay_esn->bmp_len, 4, &len)) {
		return true;
	}
	if (__builtin_add_overflow(len, sizeof(*replay_esn), &len)) {
		return true;
	}
	*plen = len;
	return false;


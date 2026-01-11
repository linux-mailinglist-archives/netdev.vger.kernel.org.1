Return-Path: <netdev+bounces-248836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A46AD0F7E6
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 18:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB4873018181
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFA2346AE8;
	Sun, 11 Jan 2026 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDDfIGN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053E199EAD
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 17:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151305; cv=none; b=atJfLER9UjvTZtIG1BhaROUF04vA+u8xm+U3AKAMdYRIn5HjzGr77StvUNuh8Zr2ZimEq4gh3kR8CtKbjs5tU/VMHVRAF6aEQPhdyJ52KrNdeQVnCS1G0+4QHHc2+K5Cgp5J1X2yuwgfMKjk1Mi69aOmn2l9Mo2NK+oxJggVDFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151305; c=relaxed/simple;
	bh=ChxTuCZvDUxRj0pzYcOTPUDgcdgsScGVGKXoOlnMjuY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iiHMxIufPYozpjEhpOFjxLdEU4cXrjE3tqPkz2dY7urpWWLTbh0H2TPlfH68IQXQ8IiGIxq9d+NO3GPR38Ioa4lW5hf+w2GyHETXd3czbrKDtLo0KcNbU1nDD31V4u+gZJrgLYKFcNgKrX+1THbw6zEuQ+0nnb+/y/aAVqVyOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDDfIGN7; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7927261a3acso12198587b3.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768151303; x=1768756103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuts8d4YIvfPpo7zSeg7lhaXQ3RjFfA2fgISxiZby1g=;
        b=TDDfIGN7dSxuh+3jF880+wno6s32TFMab3UZvpQmNQNEVOi4P0Kf7YxPkKUVz4+1wY
         /z6lWiPZ6r9U0uUx+P96zIZs1N6yUMe/VsfQ0iiuhm9VCLafEbAk3rv6/c9GprmiPN7a
         Vh0RvU0vV30O2qhDImyOHlJesC+uibX7Tfud0WhN+PDOCZapxBR2USWkBZE/sjkb6Zoq
         VsiW66ih4RizXghNWX7N2Iq0SxP6pxNTchQZgflM9bDdfcdgc7NGe+xgNlkpryG92ziG
         3evxlEuM9ZD4NXf5a8201k+mBODQabevCks/gN1HdR3BREe7i+BxOJbQdUVnkpMeFYV7
         0RJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768151303; x=1768756103;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kuts8d4YIvfPpo7zSeg7lhaXQ3RjFfA2fgISxiZby1g=;
        b=RhnRriVjgZNiSh2xa/ImMFzr60yVA2I+sU8nnhBN3Fh8PLz8h80kydFuWelzNtmUMg
         vwAs+IrV3jDzBD3j/Yhdw+hc4UiBoQpxzb+/2zvB94TN24VUjo74tsXuHZ3Wo5p7VUrX
         WnXya1PJWBtyOI1iGGieOgnISwjMgcwlQlxax3bZSNxXuJum67e+zfufBB88ca8x4tHs
         RnqOb9xLK0H6Lv8q2hcDyz5m4YgrcehZaqPeYwBC0wV4wv+aRhtrZFjwSgjSbPV5vK6F
         UzYtvFCYyNq1vKPGTidR1OvLnMoSrv2XaChh++YcJ+4Rwywb7uVsY/gM9REp3sNMXp/L
         t8Aw==
X-Gm-Message-State: AOJu0YxTdRnX9hFSMayFKnDPeRVQ35k6qfWruEuxtxLWqZaDf6hA6u+Y
	fWJTIn0filHtyQ/PBXdofjj+w43DU6O+wbmcb92RCg7xO4vWXl2S+pbuNWX8MQ==
X-Gm-Gg: AY/fxX5unhAqms77bstGxqi1/JVRXQkKHdzdCMTII11IvFElgztWtpAXQLyfzM1bcyn
	75EGOY5bD4HSGxbOu0mmS3LS+AZudJEKYoi1cbfKrbjJnvgNdPBjhrdg1jCjcHZEHrjpL+jiTCa
	jbJnDMS3b1l6NYPrUTAxT4w62sFxPyGm+U62PBsxi7qA/FgYm0lUx8OyiKGHls9dRTh8vQmSdUZ
	MZJQXrVupvae+Mm5S06GMG6lC7PiDAMM6sJO2OBiHv0RK6vWOwn3mAE7ATo75YkobMahAp4Nrw1
	NCyNRZCLhVcEK6cZF43/TCUP7zq0rmG44JDf7XoFSwKNE//0B3KzOsWhOukQM0Quz8JhH1vSceD
	y8C89HdQ3VOCq7fmVaHMgvGe3tCoRcKC/GUzNx6NUVugHXYkIVJSHXCoIFOyRNF4VOXs7jzwBno
	ni7vfJ/jufw+/78klSM1wM34Y5MdKwXEuIfHWMUiY5A0ngOXW338YGs557u5M=
X-Google-Smtp-Source: AGHT+IFzgnRfZVCjNlKbdGDWXfdLVr2VOWnc0qOcIUwEtVh4gfYVIqHsPgT7BiosX6Pa71Jang7nUQ==
X-Received: by 2002:a05:690e:1243:b0:63f:9979:2f9e with SMTP id 956f58d0204a3-64716b35d5dmr13846068d50.17.1768151302743;
        Sun, 11 Jan 2026 09:08:22 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa6f09besm61725107b3.56.2026.01.11.09.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 09:08:22 -0800 (PST)
Date: Sun, 11 Jan 2026 12:08:21 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 sdf@fomichev.me, 
 willemb@google.com, 
 petrm@nvidia.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 willemdebruijn.kernel@gmail.com
Message-ID: <willemdebruijn.kernel.28340b94dbd01@gmail.com>
In-Reply-To: <20260110005121.3561437-6-kuba@kernel.org>
References: <20260110005121.3561437-1-kuba@kernel.org>
 <20260110005121.3561437-6-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 5/6] selftests: drv-net: gro: run the test
 against HW GRO and LRO
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Run the test against HW GRO and LRO. NICs I have pass the base cases.
> Interestingly all are happy to build GROs larger than 64k.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>


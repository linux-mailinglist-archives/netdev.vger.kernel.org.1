Return-Path: <netdev+bounces-55641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9E480BC81
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 19:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CEF21C20381
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 18:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4E51A27D;
	Sun, 10 Dec 2023 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="zQmSwO9F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8875BCE
	for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 10:06:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d06d42a58aso34145015ad.0
        for <netdev@vger.kernel.org>; Sun, 10 Dec 2023 10:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1702231588; x=1702836388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6X4Sv45Bn19Fs41anTWfCiVYhBCsENhz4BlH3cMM7s=;
        b=zQmSwO9FXfSmYwwm2vYVFP6YVi/MXHAA+L+EiCkogCCgSFqD4SfoUQ9E68hMwJNf/e
         2ssYAk8pY3XE/bXlkYE/eJqI5v0QFjx4dy+8eT8wB7lnN3hhy4nhzKSuyJTiKe6deEHx
         59UfSd47yVkLK2rB0fflekUrOXhY2ei5KRxojVUwn8yoYvS0BLy6DLHXrOp0jOEs3UBb
         ZeCrFmqROoiNaCq41BNopMoKSRzbwAfpSUbdvpdUtOvgfadcEX0Ftxp3Bi6xTqTmU+6A
         Xn+qYYXPGwpkz+hqPQp477AfUViAQCCarl/uim3XEE6WaAAXhHu9PubAWJOD7puh8YHT
         Sl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702231588; x=1702836388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6X4Sv45Bn19Fs41anTWfCiVYhBCsENhz4BlH3cMM7s=;
        b=WLeTWjAiS43FLpPWIH2RSKVPlw4RzP/XfG9SCwSbCbANTd5cM+kEcWToPp/XRW5ijV
         6VhKTTnzRA97FwydnlA6h6hELPx2tsQQ7IVm+TyXqGmQLpIqoIvJDPMMFA7RywDoCwVi
         1p6aol4zyFzjI7lLtqpHsz/mOSv70iYmQ1vbKw9PffTZeP2S76QKjHHQ6wxcaUVK+VN7
         oeAIIGV3Himlzo0MyUy3Tv/VJVQKFId4s7esuzxtoYj/EJsyob3lNNNwkugfxN7GmvEi
         kXmGPZ0XnzvqzYV9JvtCyFaJ/PTsukafKtHLO7GZDssSxEc6fN1P1AxKhpVyRSp2ZJ55
         QMwQ==
X-Gm-Message-State: AOJu0Yw06lyViH1adHSb0+bL2dFDo7kV7+DHbIUEmMrES9vXgs09PwF5
	zTU18qCX4FkwVnGNnQMqZELW3g==
X-Google-Smtp-Source: AGHT+IFdNzphkzTyrXl6sM+S+JDGngtMBFYoU6wwsQL5hI8Voplza1eR/GwoPFx9iF6bldWDqe8QuA==
X-Received: by 2002:a17:902:c94d:b0:1d0:6ffd:e2bc with SMTP id i13-20020a170902c94d00b001d06ffde2bcmr3517906pla.86.1702231588024;
        Sun, 10 Dec 2023 10:06:28 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id i9-20020a17090332c900b001d07b659f91sm5042699plr.6.2023.12.10.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 10:06:27 -0800 (PST)
Date: Sun, 10 Dec 2023 10:06:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: ditang chen <ditang.c@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] net: netperf TCP_CRR test fails in bonding
 interfaces(mode 0)
Message-ID: <20231210100615.521f290e@hermes.local>
In-Reply-To: <CAHnGgyF-oAnCd+NdvdZVzhE4VZLnK+BcVBH3gQqm9v0Q1s_QGw@mail.gmail.com>
References: <CAHnGgyF-oAnCd+NdvdZVzhE4VZLnK+BcVBH3gQqm9v0Q1s_QGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Dec 2023 23:16:20 +0800
ditang chen <ditang.c@gmail.com> wrote:

> 1. client/server:
> # modprobe bonding
> # ifconfig enp1s3 down
> # ifconfig enp2s3 down
> # echo "+bond0" > /sys/class/net/bonding_masters
> # edho "enp1s3" > /sys/class/net/bond0/bonding/slaves
> # edho "enp2s3" > /sys/class/net/bond0/bonding/slaves
> # ifconfig bond0 up

This is a really old legacy way to configure bonding.
The better method is:

# ip link add dev bond0 type bond
# ip link set dev enp1s3 down master bond0
# ip link set dev enp2s3 down master bond0
# ip link set dev bond0 up


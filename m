Return-Path: <netdev+bounces-80380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D972687E8F2
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158371C21900
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284A537702;
	Mon, 18 Mar 2024 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="keKuT7R2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A834364A4
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762747; cv=none; b=KU5Gm5s6K4Pl+4YlP1q60bvRvrbgqZd8atZURqAn+erIDgx4U3h4vkR9B7+YHz2AYk/f3/ia6f9DuFT62WF4B8vcmKL4+0sFzskuOY9Wqhf3KoGSoE4KnwrUatWHRbPsyeEP1wvkjuSmeQMB5ZlajYspQJ8oJ/5EYQHdAyXM2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762747; c=relaxed/simple;
	bh=0BzIfye21/bWosXW4BcFFyrAHwpAzD4F93HfAWpMzfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/xBbdo3jQWDCm8NQfrjLlT/Hgxx6a+O/1HyYLMCBbt+CWU+B4X8bOzP4Je5jqpzlAZpVKBDwoav6AGx1f12+g1nF494hkSCn4pQPHkgVnM20nHj2mW3ywSpYgdGVSG0PelMLbuUAlzPjMRqNrcPlQVOvTvcmyoDKwxOGCqIdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=keKuT7R2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso400990266b.2
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 04:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710762743; x=1711367543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0BzIfye21/bWosXW4BcFFyrAHwpAzD4F93HfAWpMzfY=;
        b=keKuT7R2aTZsDwHamg2wpevooc1yj7HpY6a78eqEGJ4i6l0sYR0d5GG4WjpIfCyTfl
         GhEmSAcpoCR6wpJGf72W9XOt1aqooc2vflR3GOyGGAYFb5pUk7VbnH0gpcpgCrrmWLqR
         JskxTcgWKO0rs+dv2EE02Pa8PUVWmdnYj1Fy2Hi5rtVeqs+vPpJoklS6m2rMbFPsFSle
         b7XqygDebR4rzvTxKStL0dwcAG2gJXWdYk4AFt5sBK792MuPiO5PQ4uWWbK40SWVDSJC
         9qMaCNnDWUalyvDHEfhkeAid7pIbwnIVnqGveU3qKtzjwN8lM2YXpaowtWW0bx29ePkf
         xg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710762743; x=1711367543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BzIfye21/bWosXW4BcFFyrAHwpAzD4F93HfAWpMzfY=;
        b=p+2osCangeks9vL05r8tPYiJaTjOVuqGKXEAOBUBr9B6xxBNYTfFLtzfp0RwUH0806
         6WlRK0b2Lw4bBEFF7xjVFL/Ln85mpbcGTvTT7vhSJWjNUWvGGm+ugGd4nL53zkvMIVXe
         x4CcVG97lxl0B56lyFKxDV6g1Dtt2ZbeCrhP8f9jxKJHrCJwvm5EXzld2aPSi/2P+cv9
         IJ73HuqxGvppEDC4LZYCRsk/eKOYLAj7swBayMIB2j9aZEmvCdoPV/J0TlDptajjBEEB
         c0ItTVurIFHt74XKz9H4OaWEAcbGWn6lJgSnoJrB0zA/P7rfbu7JC7Zoaej1IGQxPILw
         Zz1Q==
X-Gm-Message-State: AOJu0YxpmMPzttb570Jxud1QOnPYFyYZG9sLnVPcQmTEp1qtKQIRlGAS
	Q6wSMPz06A9zwj9ZoCv0fjoO+MH04Ll/WzSZo7OKfkFO4J8cn2Ik98R0b8YkAdY=
X-Google-Smtp-Source: AGHT+IGH7Az1fjV3uZRCOp6EukepU1Xx4ebVyR3uACiFNu6khcE9tHSFcToOJxhD85O+9LXpwZzJBA==
X-Received: by 2002:a17:906:5ac5:b0:a46:cd44:827e with SMTP id x5-20020a1709065ac500b00a46cd44827emr752259ejs.73.1710762742845;
        Mon, 18 Mar 2024 04:52:22 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906c00900b00a46ce8f5e11sm311953ejz.152.2024.03.18.04.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:52:21 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:52:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Message-ID: <Zfgq8k2Q-olYWiuw@nanopsycho>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>

Mon, Mar 18, 2024 at 12:05:53PM CET, xuanzhuo@linux.alibaba.com wrote:
>As the spec:
>
>https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>
>The virtio net supports to get device stats.
>
>Please review.

net-next is closed. Please resubmit next week.


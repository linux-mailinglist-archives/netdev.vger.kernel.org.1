Return-Path: <netdev+bounces-131733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC2F98F5FC
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4961C21812
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13DB1AB536;
	Thu,  3 Oct 2024 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNos4jdp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FEC8BF0
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727979952; cv=none; b=Jipy+WUv1BkZvp9M1iKiM5gCReBDinQVdbbq/tq6dIZ5FYWNGBo9NbBFZbi/EHCTXhoC/cOEd3KNeQqswePOS5l1Mli1oXrIDWf/hAYKlP6OHdniedOvPYAaZHEVdqR1LgzUt2adQuvsWOp2qvfmjfwWG3nMWSkO3xF56s6PaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727979952; c=relaxed/simple;
	bh=VGOjcYz6UybyttbaRRC55EgjhkODZY6QYHHze9Ztxw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fp7Hi+uLmtKNQLxA26BdZwg3kOxYhsoEVq4ff7NwnC9O94VF5kmcgOfUXzogognuINlHziG9iW99RJ/u63Qquc3Fj7G/RssswPkblloCMjubYoF3MS/0xckMbVzv4fscuzsBMoKPrlpbPBxgwPi5CJb6xdYyCelt2AHFO7AjO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNos4jdp; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4581cec6079so39711cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 11:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727979950; x=1728584750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGOjcYz6UybyttbaRRC55EgjhkODZY6QYHHze9Ztxw4=;
        b=iNos4jdpUvyaRK1GVPOlm3+b6XgmFqrIgo82q/rW7siTZQqKDh35+wB5HbAi0PmeVy
         cuDO8eOanCdmAMgEz153cVElmjWy5XqijrEmhGtplAsdJVPmK2KGURETRC8cL+535q4C
         MWQa0GJVrZuU724sZnf2nqBeRHdNqJEWs/MsXIbSKVJbcfHjQWXq4WUQplCXl215pYRl
         sVz52QFrXYd4QIhKOrvMbGsehiCFfXC38J+wiBdmwgIefG/MCoUzK8Lk6C+XXds94X85
         jH4Fm+bPnyBgODDkm8Q3ICJori9rof+0/F+rlWsf5yHFKj5jB9evPAJN63UXjXqbHfmv
         MAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727979950; x=1728584750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGOjcYz6UybyttbaRRC55EgjhkODZY6QYHHze9Ztxw4=;
        b=rpNkwaqp0OeF9Dc7c9/yLH1qjl5fU0wazNfuLQ4h5E5QNcHFUhie9mfelTYnlyu/Oy
         AYlGnreOU6pwDMeqLvCzqmTz10XOgXMMV/thD6qxRH5RyF4lLW2SFZRCnXS7mBRtwL0O
         Jh/l5mGoTEbq8yrGCU3jdi3sb+6iSErK7/9hpfHYnmZtd09W2K9O2f16ZszgIgprgQLn
         +Yh5Rnlzyje9n7LdYC7qwBANTc1FdX7Zpji9MLwZD+NmIm42W9gzDaPluVjSvdlwDxlt
         tWWqd0MYG+hSV0eMhFtb/2wen6XHPE0c9yUeMu8SAG75InGsWfH6Q8GekKCnbTtSMX4Q
         Z/nA==
X-Forwarded-Encrypted: i=1; AJvYcCWEispIiXyUmJLeHGdQN65MKDt5Ui3Upk38B7XUH8lX9MrzaBDM7ImCYGkhraNRKBHeBWElZlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrH3p0tOAUzBT7rBqHQy/1wY4NNY3RCUg2dZl7g4N9n+KBIMRd
	s60HLXDRFzE2/xDj9DXth2bA3cquzGP9ZDrpXnKCqGIQzzFOo3lnNqmihFtccF42OL4M97ni6we
	eArpJSTTZO81kLWBVdBVAznnWuDfdT0zY6D7o
X-Google-Smtp-Source: AGHT+IHmhsJ2wZ+FQNs6aKV1vufCR3C4a40ySZnmiOmRXAH3glcWiJ2NA4lT6jUKNG+hnFxR7msOi6nfSNhpKjm+3Wc=
X-Received: by 2002:a05:622a:2d0d:b0:456:796b:2fe5 with SMTP id
 d75a77b69052e-45d9bbdf1c7mr56261cf.9.1727979949918; Thu, 03 Oct 2024 11:25:49
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-4-ap420073@gmail.com>
In-Reply-To: <20241003160620.1521626-4-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 11:25:36 -0700
Message-ID: <CAHS8izM1H-wjNUepcmFzWvpUuTZvt89_Oba=KaDpeReuMURvQw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/7] net: ethtool: add support for configuring tcp-data-split-thresh
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 9:07=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> The tcp-data-split-thresh option configures the threshold value of
> the tcp-data-split.
> If a received packet size is larger than this threshold value, a packet
> will be split into header and payload.

Why do you need this? devmem TCP will always not work with unsplit
packets. Seems like you always want to set thresh to 0 to support
something like devmem TCP.

Why would the user ever want to configure this? I can't think of a
scenario where the user wouldn't want packets under X bytes to be
unsplit.


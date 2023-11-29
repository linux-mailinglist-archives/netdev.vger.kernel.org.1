Return-Path: <netdev+bounces-52248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA97FDFA9
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503691C20A6E
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1FC21A0C;
	Wed, 29 Nov 2023 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba0+Azrq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C0112C
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:48:14 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c997467747so1909321fa.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701283693; x=1701888493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HFkyjCpOo8uaGddJn6sLmm8I7TRC315TTbG9JjOcaQ4=;
        b=ba0+Azrq3vhS9HOO7jVct9EUK2XdNnhbiT5HQovwOnZWGEWQNNBUsRGMwhcuIA5lsd
         NBKyYf0j1gVOdikvcVvQgB1ykep9WLpPca+9LmPFtTmumZV3jNnz6sz+nffSW2TYBjwQ
         ED3vZEbSocWrIjv8vqGiNXLEVkFKiGJ9O4M9y4oRFZDSOZIMRNGdeFpVXKTYdiQ6q008
         2oER6USANfMtzJXGHvCPwEXuEqhlQ/+BKoriD5Jh1UtczjU6p+9btkxyigZQHjCE5PH6
         xcP03vOm180jJNR25eG1NrwIUDcxMgonnEYXGKPnbL3Rr0rL+JM31KFu9AoBdxkHZlzY
         bpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701283693; x=1701888493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFkyjCpOo8uaGddJn6sLmm8I7TRC315TTbG9JjOcaQ4=;
        b=qDbEIxZH+QtEynzUS3OBstcp6Nb6Ff/BsfHkCI1iBFdzE7Nu07amtTIHoBo8WWe9+T
         tGpNZUfFghpOf7s6o/aApTsejg0muYP6J5WWy/OC8nUAx+MQwRkeCI7wgkYRIhbggRWB
         QLO9nlO7OPvoJQswrQtlyZr1/ODB/wlkiV4J5IlUG2t2M0PhiGTkbM3podCgnpNAGhpc
         xXalmdm0XX2opGnYzdcujzd87/FLPO2K7Yyi6hskJTWeHvkMMvTyJGLzAUvw4XQevkVX
         bJF0EuwWrW0MfTZGqYnGQqthCAxyKk7AqPFabxamIIHyKJfD6a5RAPTwkhacAkrNlkVE
         JkNA==
X-Gm-Message-State: AOJu0Yx6bivNgHUVAIg6+MY+tTvtrQ9cHPq1m8xCOQ6I23Mot5VRWti7
	W/I2vAWMeFPUuYqWeI3QYMM=
X-Google-Smtp-Source: AGHT+IE+lq3LXCy0qKmMlVbwQMxMIV8slAjgrKRu9GGaUlGm5WwAN0bd+HhCYDNaJCxWj7EEI/LSyA==
X-Received: by 2002:a2e:8e37:0:b0:2c9:9a91:798a with SMTP id r23-20020a2e8e37000000b002c99a91798amr8059885ljk.14.1701283692590;
        Wed, 29 Nov 2023 10:48:12 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0040b47c69d08sm3096687wmq.18.2023.11.29.10.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:48:11 -0800 (PST)
Date: Wed, 29 Nov 2023 20:48:08 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCHv3 net-next 05/10] docs: bridge: add STP doc
Message-ID: <20231129184808.vsmp3waba4suvjk2@skbuf>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
 <20231128084943.637091-6-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128084943.637091-6-liuhangbin@gmail.com>

On Tue, Nov 28, 2023 at 04:49:38PM +0800, Hangbin Liu wrote:
> +User space STP helper
> +---------------------
> +The user space STP helper *bridge-stp* is a program to control whether to use
> +user mode spanning tree. The ``/sbin/bridge-stp <bridge> <start|stop>`` is
> +called by the kernel when STP is enabled/disabled on a bridge
> +(via ``brctl stp <bridge> <on|off>`` or ``ip link set <bridge> type bridge
> +stp_state <0|1>``).  The kernel enables user_stp mode if that command returns
> +0, or enables kernel_stp mode if that command returns any other value.

Blank line between section title and content, just like everywhere else.


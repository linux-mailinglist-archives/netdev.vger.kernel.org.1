Return-Path: <netdev+bounces-51385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBE67FA7AD
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A35B20B3D
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5C93714E;
	Mon, 27 Nov 2023 17:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MamGkzfV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3782C10F6;
	Mon, 27 Nov 2023 09:10:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b402c36c4so15542215e9.1;
        Mon, 27 Nov 2023 09:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701105039; x=1701709839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZawHlo7ihhM3P7f9lODEcARYXH4Ryf9ttNMsaPKDZC0=;
        b=MamGkzfV1OL3RpdeEG/qMYioQ8sBNxg1NxYeE7XPkAmpSDQV7b9ch5O9fLBVqBUXGr
         zzFSmUyQNVaZoBF4KL4xSCit/8ogK0lJHAxIxjv2bhWO3waWqq4adQRwVvnCTGhXRtjd
         BrJKrG1d5Vxsze9XV2DHgySgtIlQDwpt725cXZh320l1dn5bTV8xKaUYyW7mC7gMgA5Q
         zJQJVzLxyfbXGxKBzzVaATkvg2j3fRJtXXpAqFmdmMOzwem5e2JFZXoTqaHn7kQZ83lS
         8cuYpbUMPffXq0IIXKs4eLVc2rwUrI8++AVle2x4ZuD+Baw4KC+e4ek5kr7UcGvasxs+
         WErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701105039; x=1701709839;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZawHlo7ihhM3P7f9lODEcARYXH4Ryf9ttNMsaPKDZC0=;
        b=bClpk35j37rvvmoLTGKTasyVOVCR/enryrRBXk5YY09zL39jNmL18efwNfy4trTMy2
         PB+iviViIUUhGcFNvKJnD7YpJicwsF9vOMphLgeyX8Yykcvt4q5v2zB0qCNW5FktKEfx
         I0dTTAzxPVz99vWGjL1CceIwbzvbOKQQgJajuN5eC4uLeuuxbLfk2Uc02yNyRGM0FUI3
         6QLcwo85vyVxVgvugHQet0ZyReFHi8FRgAAPslHxM6neTuLU78+0G8OK2aorhU3zimu5
         bTgsR3kIHgWOmc6dqXkn6sXd/XQ0PlxeFSF3QoVh41TDy5qAuwO+oBWTqXqhjFtLzDOY
         f6jw==
X-Gm-Message-State: AOJu0YwjZ8PwveQLeVQyRke0b4z8K7OgRGFj5csPsoovqcgE50cK0AHX
	fuoT2rFbpUISyY50721Oqyo=
X-Google-Smtp-Source: AGHT+IHlqMryunqFzONkDzsQFOB5kDNnfitWeCTrN8xajEwOus2AtFtoco9WJWnQMWq1yvnHkERF9w==
X-Received: by 2002:adf:f48d:0:b0:32f:7901:c462 with SMTP id l13-20020adff48d000000b0032f7901c462mr8879689wro.3.1701105039278;
        Mon, 27 Nov 2023 09:10:39 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d6843000000b00332fd9b2b52sm4700440wrw.104.2023.11.27.09.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 09:10:38 -0800 (PST)
Subject: Re: [PATCH net-next v6 1/7] net: ethtool: pass ethtool_rxfh to
 get/set_rxfh ethtool ops
To: Jakub Kicinski <kuba@kernel.org>, Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, corbet@lwn.net,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, vladimir.oltean@nxp.com,
 andrew@lunn.ch, horms@kernel.org, mkubecek@suse.cz,
 willemdebruijn.kernel@gmail.com, gal@nvidia.com, alexander.duyck@gmail.com,
 linux-doc@vger.kernel.org, Igor Bagnucki <igor.bagnucki@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
 <20231120205614.46350-2-ahmed.zaki@intel.com>
 <20231121152906.2dd5f487@kernel.org>
 <4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
 <20231127085552.396f9375@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <81014d9d-4642-6a6b-2a44-02229cd734f9@gmail.com>
Date: Mon, 27 Nov 2023 17:10:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231127085552.396f9375@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 27/11/2023 16:55, Jakub Kicinski wrote:
> BTW, Ed, this series will conflict with your RSS context rework.
> Not sure if it is on your radar.

Yep, I had noticed.  Was wondering how the removal of the old
 [sg]et_rxfh_context functions would interact with my new API,
 which has three ops (create/modify/delete) and thus can't
 really be wedged into the [sg]et_rxfh() like that.
Tbh I'd rather move in the direction of using the new API (and
 associated state-in-core) for everything, even context 0, so
 that the behaviour is consistent between default and custom
 contexts for NICs that support the latter.  Not 100% sure how
 exactly that would work in practice yet though; drivers are
 currently responsible for populating ctx 0 (indir, key, etc)
 at probe time so how do you read that state into the core?

And I promise v5 of the rework is coming eventually, bosses
 just keep prioritising everything but this :(


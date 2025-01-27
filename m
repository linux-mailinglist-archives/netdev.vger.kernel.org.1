Return-Path: <netdev+bounces-161117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5CBA1D7E1
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 15:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E528C1886482
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 14:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBCA1FE467;
	Mon, 27 Jan 2025 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwafEZOm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F5815747D
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737987287; cv=none; b=eX6AUtykNJYazKIl3njfkQqEje0ss1e3aJSwLEGYJxaM8tBlJ+xVswlyRPDzDZ3PlaEY6jHOxNnOw3kTRMnzkhoKMyL9JGyJ2IEYkG3IhzSIR6+44u0qrc/BM/XbvRXxKk3hJSlWYhlaQ9RKulFDLD9JZk9YlB4jLkWfL4bFIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737987287; c=relaxed/simple;
	bh=q0hnqzxRKJe1xlk3rjc0tgYufyPj0tvzGIF+8G1Tygk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kGIr/1iSsUpjmyIqcxycdSTNOja26wCfyvBdxiCd4DLQwtzf9ArM4lW+Oe+nyNHN1sdiLzThKR6lmTkWMSwJd6ggc1uikoSSSBLc86raI4RTXn5dzBHBIWew/be66zNbSszI3GNT1wRgWfBpeMG8aD1TkLvwge8YP6RSc9OzmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwafEZOm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862d161947so2312550f8f.3
        for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 06:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737987284; x=1738592084; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7OEX1FEH30CiSTxvGdqR6kzrrVdogX9xTrr5eYHX4c=;
        b=dwafEZOmWt4OvkdacyVGTQQ8BVHLTAv46RZPAb7QpYDJYHp5EUqfWs11W2X1pa/VnT
         qNH5wrJH9xtnJ1rb+kCUxPv+pJATCLUmfGHno15hUAWjcAA0BSDLbMoi1/fbd+VOxIZU
         +fUN+VrqwezqdLuVD7CE9ADO7E8HNlt59OmyE0k5n5rJJhHAjxIcbbicsxBkNMh0xc0g
         KlN06rEm2NVdU4oYispjh+dYKwVfFjE4KdjNgVCZxdnYIrutA7nl8sods4VypNsTJOIR
         yH0OaCcFCn14DDUpUEq7ZVU5pBiJJJcukFUSRVsYXHy0fSZ6OwVADdC/AhR9LwqpCMxi
         xaRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737987284; x=1738592084;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7OEX1FEH30CiSTxvGdqR6kzrrVdogX9xTrr5eYHX4c=;
        b=ZL3nUmwT9KI3y5y0kGCbsOw6bJFb96RfuDs1QXXxqghlMv9Q4eVhZfTImQcZP/mJVk
         pi8dsd06zALgZhmVoqbxx90+9+NzfkDKzJiZ1pB4DpMhLoow+15VhuGfR2B4mKL7CEa6
         wwW9h64JgMMR7LW00h7TCYcnH7Vx7/8zFJPCrqVQVmPuye2LufJ+ofJA/Is7Q4tSCh/e
         jhWFGlgziq8iaWMoBY65u8zjntw19yYxkMwufglwnvRsnW57vfMa9q0s5SXxcN/BEOWm
         aSxPfLj0pyETZsxVUZI+/n6ILVukKBgqqC8t8WT/iGTtfXVYH/ys+xPNrnXnf8dPn3IT
         EGcw==
X-Forwarded-Encrypted: i=1; AJvYcCWXswj878Xttu8gVS7/teKBsvXn6PA7tbK+KCLkOQEQcFtn8DzBJElQp9Q7bf/StT+SW+Nk8Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfeFrQXxCLE9aTW/773cIqLlQLSynJWDfhCYkwsRe301dsidBB
	mPyGQaDitqe3Xt9BEKNIrrbz9qxRpvvyDLuj2+j+7UYzfVcz/qA0
X-Gm-Gg: ASbGncvFxnKSi643ZmJYgLxFtLNUa3GJ5mU+QXRC+kc6zciU8DUMDWHO2eFvf6Hhh5f
	F9ZsgaamIsIHP3tMcojlTE61Pl6dpWbqOxquGWFmgPYC6MjVWHVYOWe5jQ13zCvPxcpgsMfyQWb
	FNt92BAeyP9L+oc4rFFDURuGb91vzzZdulixRQLMC8XHKClhp+zHLcxpq1LgrssuHToO6kRjoH8
	yTgNuF5rlWHUaRkAfWHhM0RPFB+kJ+FqSe39+TUSP6vakOuCYa7k/5iNEJlb0bOcBfS65OWFfIQ
	OWJwnzpGvrRxT6vVBlgWZLSOEQlwmEs4LEju1e7rBiiyl7pJh5ATlsrVTLLglrmEMeTj
X-Google-Smtp-Source: AGHT+IGEL5JL+cJVUE1bYbaZQ7AmorMrsrb1eqNQjioeHxGKVZpxRCj5puuA6vAAUFwzNi0gldGodg==
X-Received: by 2002:a05:6000:ac1:b0:385:f7d2:7e9b with SMTP id ffacd0b85a97d-38bf5673c57mr23086282f8f.30.1737987284242;
        Mon, 27 Jan 2025 06:14:44 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1761f4sm11179423f8f.20.2025.01.27.06.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 06:14:43 -0800 (PST)
Subject: Re: [PATCH net] ethtool: Fix set RXNFC command with symmetric RSS
 hash
To: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20250126191845.316589-1-gal@nvidia.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <d0bad3a5-1f5b-9b48-59f6-879ea803efd7@gmail.com>
Date: Mon, 27 Jan 2025 14:14:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250126191845.316589-1-gal@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 26/01/2025 19:18, Gal Pressman wrote:
> The sanity check that both source and destination are set when symmetric
> RSS hash is requested is only relevant for ETHTOOL_SRXFH (rx-flow-hash),
> it should not be performed on any other commands (e.g.
> ETHTOOL_SRXCLSRLINS/ETHTOOL_SRXCLSRLDEL).
> 
> This resolves accessing uninitialized 'info.data' field, and fixes false
> errors in rule insertion:
>   # ethtool --config-ntuple eth2 flow-type ip4 dst-ip 255.255.255.255 action -1 loc 0
>   rmgr: Cannot insert RX class rule: Invalid argument
>   Cannot insert classification rule
> 
> Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>


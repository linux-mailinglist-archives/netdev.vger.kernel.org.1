Return-Path: <netdev+bounces-77070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CF887008D
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D941F269EF
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CCF3BB46;
	Mon,  4 Mar 2024 11:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdWMeVWV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9543A1B5
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552490; cv=none; b=ktUc/SrCTuOqLvIl2Pmb2E2F8rJIAiCegJ6Weg2WRR/L0b0tm4a73OQYzOXv0utRIrRAC300oV+8HO6eCxCYlPMz3vS4CU/VkwlDCigTNlD1UJTzo4uOiMNziXJ4YPluj8XxefqSl7EFUjMCQG2rBoMQC3IlS1h3ozDoILZXVqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552490; c=relaxed/simple;
	bh=5Q/avAi0qCoor8D4aP0HFs42ajxyGEEe7bVE5wuHwMU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=VmdS1vqpR2PgpCfplIm4j1av4oVArcRW1doYqyyIdUR2HZEBauIlNWNieJ/QUtLBDnv5d82EEkaYauc1c/65IuOZY8EETdzMO3EbsNDjWo5eyC608MQfC9xDjQ0TOIeYK8g4j4jWvR50E0FgS2nP77ENzYC/iKNV4zOhaBmqfME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdWMeVWV; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412e72b0d96so2490925e9.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 03:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709552487; x=1710157287; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q/avAi0qCoor8D4aP0HFs42ajxyGEEe7bVE5wuHwMU=;
        b=WdWMeVWVLZ/gjdH+zqicuzsq78QJTeKH2lDfE2mw53aYpsuJ8bX2xUfRLKqniiAZD7
         d5VUtS5zT9c/+Vf7NapIjk2EKbwzKbnD9N+jyv5wodxQve4j7JrVD0O9U20Qw2gO4uu7
         vnQlXHOa4LsJgxzAG9+YmDyAm1f1jG33uPUWl2kck8Ao7G7L0TJSAssnHz3e4hB3PjZ7
         g7fG4JpqNLC8HC69IcTwz7SlS8KFe8yehMNyAzvUkO8oYSk5FFYqp2xyui4YjF8Uv4AR
         bdw0JMMaqEI3Dbwic3icuruUiGQlCMcDE5eue0LCbYGMlEsyqRc+S0bHXWbmxltO7Upa
         V2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709552487; x=1710157287;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q/avAi0qCoor8D4aP0HFs42ajxyGEEe7bVE5wuHwMU=;
        b=ktkxLZecrmvgn79SLlhOixiT0/Q58FZRPiu8y2PP3hsTaOFBtXPS5ZNk3rcOTeQJkH
         neAM7s1BdyRdFOIMe5ufr9lp4hiXc5FsqagDvpl16ZUkOnJUgzaJECzPk0FN6kzExDXZ
         F0G0cND23frb4xlcVtYO+jP7XwyVSK7N+WlqJAbVuKT9ETFAbTcUkQ5LxM9S05LvxLQJ
         2qB35ei6NN8VncM+f2lmkedNWfudQ6nX5jpm3ASny8EjNdQNdrLta9uQJMpnA2/eWSfQ
         ceG+0HnoMz25ukOmaZqzrhT78bKZCld6Aap8T7tVHIIZ4rJeqPou6ad+6nQxgb+kiQkQ
         gZBg==
X-Forwarded-Encrypted: i=1; AJvYcCULRLXspQAYHE53BWy/OHD5F+PjMHME0um6aNYe16mKUVGMPBsX6+eSgP7E+sa72EbfmJef90ePPLxpJmctPhLoH1ptdtAF
X-Gm-Message-State: AOJu0YxQ/5H8UmJU3JMqooLsvfhr/YUYJBfFN/jhkqs/IYUPxamOW//T
	KEfN2SC6Y/pl7K3SL4D0CAng4H3CWWiecllfS+KBYcZHV2F4xDbr
X-Google-Smtp-Source: AGHT+IG9a6YxaaqWJLL0N7PE49f2DgkxRcawM7ixQ64DXqkzUvBWrk5N5Q2gYYqQFirdz9uuonABuQ==
X-Received: by 2002:adf:da48:0:b0:33e:1f94:7aa5 with SMTP id r8-20020adfda48000000b0033e1f947aa5mr6459074wrl.54.1709552486851;
        Mon, 04 Mar 2024 03:41:26 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:29eb:67db:e43b:26b1])
        by smtp.gmail.com with ESMTPSA id m17-20020a056000009100b0033e17341ebesm10455626wrx.117.2024.03.04.03.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:41:26 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 3/4] tools: ynl: support debug printing messages
In-Reply-To: <20240301230542.116823-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 1 Mar 2024 15:05:41 -0800")
Date: Mon, 04 Mar 2024 11:34:15 +0000
Message-ID: <m2plwajknc.fsf@gmail.com>
References: <20240301230542.116823-1-kuba@kernel.org>
	<20240301230542.116823-4-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> For manual debug, allow printing the netlink level messages
> to stderr.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>


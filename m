Return-Path: <netdev+bounces-52247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668927FDF9B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958341C20CA6
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D813B790;
	Wed, 29 Nov 2023 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbGxp2bL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF48712C
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:46:19 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332fd78fa9dso75451f8f.3
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701283578; x=1701888378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cz+YINCm92INLOu3aEeoy2EI1iBVQPQ3Um2AX7lVQTk=;
        b=MbGxp2bLRnhvN04vKZVVWe2+h1GAOW5B8UUJl3NzG/t0qdGKcly3MXswPVnNOweX50
         Ze4+yw/8sCetT3tjxXPIeSvVfS2YVj4POqSn30hqxUwd6Mv95+68Xe3t++WRL78ny09P
         EFbGv8fPpiDYsP6o4/QhRNHqhEoGRLw9ynyTx6I7gRkA6JFVjA4LcX4nIjCBH/AVOj/I
         WvAP+Kq4Q7239EHcQPiKjioZDduMzQG1VStpJ76MZo1gRdz/zsB6SZ2WdfOYSHCE2w4a
         mF7OSI4j5hzvke9ZPYu6s/qMv8zZQFvV9RfRxBTtcUGcUzzVEanVBvwk6lpGnH/Fx1BS
         eKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701283578; x=1701888378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cz+YINCm92INLOu3aEeoy2EI1iBVQPQ3Um2AX7lVQTk=;
        b=ctcnZJyGcIRy8pCAzwW/kZy1jTg+oCmfMWTTuyIJ5jnnIH+y24ZMycHqwvnsiyMQ4+
         lRWVu5thEL1/n++k4DTKRqq4kHDA8THdh+GPsnDRraaLvs2KKlsyZ9fhguvgbxTA1V1k
         SP/WGODNeX0Vu2yL36B+8wDEOnn1at5GlV2oIRBTLY4LKt+43v2lb7CL7t+CJI0q8IHh
         qUlBbOO845ovlmHxuNMmGjoUThE7KGzTeb/scJKA6nKGlJ1W7JYQCZ9wlABO6CpOgNnz
         uQdrkGJ6b8MKkGe/NuewamqMd2jOxxPCAQgQlbAjPFwhIPFRZvJxELLaQIbOnwDO/KKF
         JP7w==
X-Gm-Message-State: AOJu0YzUsPOh+kI2Q6yCo5hjvP10nLE7X9hTkr76JN/7v278axmNcNMf
	8r8UE1tVz8aG+G1suSNT6mE=
X-Google-Smtp-Source: AGHT+IEX/rZBz2WEDEb8RGrJa8yuLzGI7I68tWl1Y/OUWBFj5bymkdM0B1fUv85h0hvgQ+Wif4Kc3A==
X-Received: by 2002:a5d:4607:0:b0:32f:7649:2648 with SMTP id t7-20020a5d4607000000b0032f76492648mr13595798wrq.46.1701283577963;
        Wed, 29 Nov 2023 10:46:17 -0800 (PST)
Received: from skbuf ([188.26.185.12])
        by smtp.gmail.com with ESMTPSA id f10-20020a5d568a000000b00332f95ab451sm11929990wrv.58.2023.11.29.10.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 10:46:17 -0800 (PST)
Date: Wed, 29 Nov 2023 20:46:14 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>, Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCHv3 net-next 05/10] docs: bridge: add STP doc
Message-ID: <20231129184614.ue47bujrivspjuks@skbuf>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
 <20231128084943.637091-6-liuhangbin@gmail.com>
 <20231128144840.5d3ced05@hermes.local>
 <ZWbrnK9VKczMrCMb@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWbrnK9VKczMrCMb@Laptop-X1>

On Wed, Nov 29, 2023 at 03:43:24PM +0800, Hangbin Liu wrote:
> 802.1D is expected to be officially withdrawn in 2022.

2022 is in the past.


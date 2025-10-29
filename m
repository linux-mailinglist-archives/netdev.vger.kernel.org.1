Return-Path: <netdev+bounces-234077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4095CC1C475
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5011884147
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CE72D8DB9;
	Wed, 29 Oct 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="aPT2ffJd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E62EBB90
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756592; cv=none; b=N6WQmZa2Tb/fDGFLEW9D5NYBtI86HRvoOHGFGtIDRFyF83hxe+2gH3Wvm+yzhPZ6sId9l3ZirXLmn8DvTiTmrRdzjW/fFCdqZc9OpMfImVwxk9cbbPZpi0EdIISo8i2ANqbSONTDi13fwOUdzv0VBRei6h9re0t/dfrPu6l1zwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756592; c=relaxed/simple;
	bh=OEKL+9e2U3k4zPS08GAvKmJoJlX2pn2d23xiFWOcqGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mn8fUwLacvWnZEU6Iqkmq7GY8ektpkfECc+LSv1to4ldYLP4Z3AlRvVNkSLZRZEJ+Odwn/1mCX/6O4wn6xInjr3CJwyRNt6ZUprYTe0Q3vrrAlMaVuMHiEcBqdYfGPBtAsGyWDqV+LIbO70Y96zmIXf/hlntmNmXSiCMYvS8wrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=aPT2ffJd; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d3effe106so16127166b.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761756589; x=1762361389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zy4Dq16ZdBGq2XMHipktaR8r2SSMWMibdB6/S9CNfRI=;
        b=aPT2ffJdXP0qmh4LV4gVswR8Ax9A5i2MyUJ1KPgrE70TQhhdgt0S93zrwA5ysm/raR
         sljA+vDR4OTCRWAq4lyuNCyCJ0z14SVK35NV4K1g2UTKbeFP83sLMqAHiOzO34Vvoypn
         sN6hpKBiqUk3RylCqa+AZg8B0O+dcPDu747yGdCtDpubpV7vdL1KiQXGQJnylB/5Eyp5
         fFn7SMelFPj0WW6dnk1Phah7Zm8RDyx/jE400aBarNYvZwM4Y450gxkfA8scf4XnBUO3
         1fA9eZjjMFNLKRnX4JQF6gEQB4bJESRHPeIiQt0k4X93q/rqbV2rl7mhrv3EUFYIi3nl
         +AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761756589; x=1762361389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zy4Dq16ZdBGq2XMHipktaR8r2SSMWMibdB6/S9CNfRI=;
        b=cl8XlqhPxCy68rw4lWy3Ctqsp750pr4lCgpSVkqLLQEhXicY1y3R/kevc2K+SiMkgp
         GlneFQ0SSn89HB5YE9MUzbud/dBM94TcSUt1CNtdPpPas9wT6RXq5k7CavrQQLk1l5AP
         q+YZ9YQRk0iNqh7zGWeoC6Q7lh1v0rRqkVfuTYVp9zbnYaSlwd9xR/9wVeDwmDQ1yEXo
         hkPghPQNJ8/rce+GIDFL1sAxDi1hV29R6fP1mmGBJdjJgEDYrHW+YqECoy7fACt1J9Hy
         QOF4dmr7MKJ5WhHF56gqH0rWtsnzVESmv2HvFt39wkycNFyYk5EpLsxpXJnsv+U399za
         dkrA==
X-Forwarded-Encrypted: i=1; AJvYcCVIC+Gf7bbPPbysyBOKSL0dDxYUcrSrqIXn03RSLJ3yLGgQr56UDoPfTGENnb41iwxq+MOlW4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSF7n9z4uCGruqtjTQFxYfd2A9OHZVRxeGjTZHgRPsVCpVmV9f
	Ms4vVUwdmmcV8aAF6jGt92D9iDoCR/BuneTgJn4O+Px1psy95DTXs7LSk7n+nGXjMus=
X-Gm-Gg: ASbGncsG481EzXDyWHReIyvtoSA3BXoYNphi6TushaKEj9n9YXEvvn9P/ynmZ21kWLx
	8sgMUYfdLF3uWkuabYqf9Mf4aWMYqUk8UZvgMwxnvu2oDlg3t4qJ48NSZ0R1pFVz2BYYfPfDwpU
	g5le8qpMeVfYoxdDU2mNLzf7z0LgKJfoSg+n6TgDWu6/JwK499xhw2xpr7ZrWpvYrhHx+udVpug
	Gces20RUgkraQ3ljL+gRYhPUsxeO+VRSvozeDpQyZe64wzDMP+GK8/dgvskLmIcqNYDYn2E7JLU
	yKN/h2Ovx6GXjAIhD50MIitm9oypbW+UcE4vfZlN8I5WBhHvT+P7vPChlrZc7XgT38IlRcF5N4O
	c1R1EE8zNqTjTU3D1MukRGOdt5slO7TTA2xkt9lhKYXdWIBSaW9OlkGySR9MXAguLarJHtpUd3h
	J+oEbarfHV1S3tmh9rb300eg1kqg==
X-Google-Smtp-Source: AGHT+IGr6hvPmvwVBK5nlktNTc8D2W7+2SjHOd2HB7EwZx7Q0yftf2aEDh2HBq/ZyO8gNseBq3fqiw==
X-Received: by 2002:a17:906:c28b:b0:b4f:3169:3ec3 with SMTP id a640c23a62f3a-b703d2faeb6mr244928366b.21.1761756588793;
        Wed, 29 Oct 2025 09:49:48 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b6d8992aa28sm1449152366b.41.2025.10.29.09.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:49:48 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: gal@nvidia.com
Cc: adailey@purestorage.com,
	ashishk@purestorage.com,
	kuba@kernel.org,
	mattc@purestorage.com,
	mbloch@nvidia.com,
	msaggi@purestorage.com,
	netdev@vger.kernel.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re: [PATCH 1/1] net/mlx5: query_mcia_reg fail logging at debug severity
Date: Wed, 29 Oct 2025 10:49:24 -0600
Message-ID: <20251029164924.25404-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <3edcad0c-f9e8-4eeb-bd63-a37d9945a05c@nvidia.com>
References: <3edcad0c-f9e8-4eeb-bd63-a37d9945a05c@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 29 Oct 2025, Gal Pressman wrote:
> Allow me to split the discussion to two questions:
> 1. Is this an error?
> 2. Should it be logged?
> 
> Do we agree that the answer to #1 is yes?
> 
> For #2, I think it should, but we can probably improve the situation
> with extack instead of a print.

I think its an 'expected error' if the module is not present. I agree.

For 2 I think if the user runs "ethtool -m" on a port with no module,
they received an error message stating something along the lines of
"module not present" and the kernel didn't have any log messages about
it that would be near to 'the best' solution. I specifically suffer pain
from the case of an unused port (no module installed).

I took a peek at the SFP+ and QSFP connector specifications. It looks
like they do have pins reserved for module presence so I'm wondering if
the firmware exposes a mechanism for the mlx driver to check the module
presence. This would clear up essentially every issue with this particular
case because I have curious people seeing the existing message & then
questioning me about whether is the cause of some other problem 
(much of the time not even a networking problem) when in the port is
simply 'unused'.

Cheers!
-Matt



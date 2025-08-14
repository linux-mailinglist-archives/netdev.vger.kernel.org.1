Return-Path: <netdev+bounces-213690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E91B2649C
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 13:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E93071743B7
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C178243956;
	Thu, 14 Aug 2025 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuTShDxV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB1318129
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755172071; cv=none; b=B/y2r4dtiIv3ukoc1abguDjqg0SCQgJRGeShTbTSqdt7xFourxikvVKWEZ1KN//R4oqls/JWkcfNE7zcUiVeRrnJdjWx8s9JSdHeRhiPbtPS5EAhrnCoYVaE1lYLv6BMrXCwBaT+Y/fu4vnmGn28KuWevYDtzP9OW78eeaos6Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755172071; c=relaxed/simple;
	bh=Teg4MA6IV9eBWWkoJwH9CcwjubqVUpW6HfwtWGTDhfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d34xdfO/u8Xg8Ea04XtkxzBWAFyi1zuuRghqoxtbnPc5APPu6eyAUEdHGhHcMbekYt0ui+H5ddsjW3/RKEa1STMb1hW8LJGHQeOAv5+GeKGayK7tQLt2DWJdHzWRnfw9MDY+HmgfAG8/DpELD9FKKyWgu7Q07ISQ/IVCncVUmOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JuTShDxV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb731ca55so9114566b.0
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 04:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755172068; x=1755776868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mJraXPLKidy30OO/YT4DT8pZWyV6bSNznKwKCSBDFk=;
        b=JuTShDxVDdP2eVLJ7moynCP/fc2b3n/Q5Ujp2Bfx3FylCUB/R9f2yTL2PaLA5FA3oi
         8TcSovhmRxmxC/cMHI8UQNBkJerYKOGEVzVGlnFcOKU2LcyKKJU9XGUj3wF2MWSBrsWS
         fMpeCAu65wFFnAwOycxRSbWiLHKDBq2UfP1OjzbZUANN2BMGXwD0/pb0pFS1ZF58ofS1
         0uBBtsoOlq9BjhZUnUxjgKS333eOuixr8AJ3grZm3Jb1L70SKwxZbKDqvBHzEhCYaShe
         J/AEVTw/SauiSmrMjZfDxvAcIo4XVtQueELg5hQVVvklWRCqD4rpDAxBZj9dJBBN+a9o
         rSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755172068; x=1755776868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mJraXPLKidy30OO/YT4DT8pZWyV6bSNznKwKCSBDFk=;
        b=nui9S17fuP2W3pZFJcIz1rK3/AzS1x7HrKIgvH9eXEjJO48HvqGe6qiErbRDw33iJp
         +PXBh0EYKg5MulU6RptVsnRp2BuJq6Lkw8NTEf9x4jZLZ1Y5x6BNypu4SCr5Sw9nTyJq
         HzF/22l1TGRFkEYHM5oV+g0X59Zju91PM++IQ7Pg/yNO9cvgPd+fJdJGcWNW9qtK1e+D
         v5jCNOcwOPYvG7KwwP/L5PKxmyBEV+H0WhF613cyaITPVUJug+y+mu5N2+nBRy9n8QEx
         KLtUZr8FAIDkkGtveI1NTZRsPotcGo0dpqj5gJEaoJ8KncI1Zx/DPvT2j2hA9PpOfyKf
         5aAw==
X-Forwarded-Encrypted: i=1; AJvYcCXB061aa+Or7cS1VXpa5Q51w2C8PzhoGWZyw+H7A04Y0v2oqNPPM/n+IfsnobxutuTeF09X54M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9IkkFau84oJdzkIiNeUbEYVcZzVKKx/eRnPOwiFGtenaCMl1
	WHIsGtQMFXROJLAdmk85KwkhC/NsuI7DCmYm3w1ijftOnl4ZvdE4VwLNoH9Fa9YCo9s=
X-Gm-Gg: ASbGnct8WZaRCWrW/3HVYwfSY4VCpCrKaW1MoPY1rHtLHlqUepeebiN3JowVSp1fj3b
	VPPJxswZ9Qj8auDU83U5WI8mbH39jQBa82oGlgOhK4zxf7bf0QYGztm4KxBAtzDvO05DLV2WaB7
	ohp8aY1K+aHTKqufSAj53wvTDLqGC6E6WV2c1/mUqXgRGDyELkGrQdmdetxe0qEpb8euPFk2TAQ
	Tpzc5Y+BUKMcmo0axyMKrKH1UtcKIT23LGubhXyyiAuaFIdJmnDLQ6jGbfs+ifdfgdQQB1A8Q5Y
	2lab+HyXuX+V7YPMen2NwQUeWV3z5G5bidXGz7TUM1srlyZSLbfwilOCPv3kKNvmH5wfyp3k0ZK
	8F8UocE83x9HJGLu032mtyn3W5zMxMMawyA==
X-Google-Smtp-Source: AGHT+IGw0pZmQDzgXoRNbC7a9tbh/ppjhh5CEvo2I21V3fx4siwNtrVGMikdafcL0R/0jrv1WoGqzQ==
X-Received: by 2002:a17:907:d88:b0:ae3:5d47:634 with SMTP id a640c23a62f3a-afcb98e24d8mr133953366b.9.1755172068499;
        Thu, 14 Aug 2025 04:47:48 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3bd2sm2557374066b.54.2025.08.14.04.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:47:47 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: linux-nfc@lists.01.org,
	krzk@kernel.org,
	Fabio Estevam <festevam@gmail.com>
Cc: Mark Greer <mgreer@animalcreek.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] [neard] README: Fix the text for the --disable-nfctype4 option
Date: Thu, 14 Aug 2025 13:47:44 +0200
Message-ID: <175517205138.50218.16737721926789479412.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250814112857.1523547-1-festevam@gmail.com>
References: <20250814112857.1523547-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Aug 2025 08:28:57 -0300, Fabio Estevam wrote:
> The --disable-nfctype4 option disables the support for type 4 NFC tags.
> 
> Fix it accordingly.
> 
> 

Applied, thanks!

[1/1] README: Fix the text for the --disable-nfctype4 option
      commit: f8627e502246ad8c0a29a834e56f5298e8f21144

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


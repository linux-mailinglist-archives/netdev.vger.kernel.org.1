Return-Path: <netdev+bounces-250060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C29D23635
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 10:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF9A63023841
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D6A3587C7;
	Thu, 15 Jan 2026 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTXX7YUn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEA357A30
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468556; cv=none; b=MZPAgueg7+8QyNn0BIrb1PYM/s0xqJj0XrlW+m45S0zwjSxL694qbuc1jhRioPosi7oppYLThD6AwUdvYThokxZW01wyOe5VXcxwhe0JIvrF55c4GzXgPU3Ojw/hq56SCGU7hWTFg+1IIh002j2i5grmqerWtMfRzoEqHuA0W8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468556; c=relaxed/simple;
	bh=0HijuXWJpjwbVYBFjlsD56UImJ6stIXjhDyb2cKuonk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLG1pzKKZe7S3blkFDw3TcenvzUubjmyKXLmY7guq4l9no6dAPBAmI6TC5xyNwHZrsdnvGMXE089P3blUXWBT3ArlIN9890qySjyBk+6jSSPZMpBfuKv+wayCbzAdlDM06JpPfD/M8iUUIPzCrPBQc+LBMc2YiFFyZZRHiXTygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTXX7YUn; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso265361a12.2
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 01:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768468551; x=1769073351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HijuXWJpjwbVYBFjlsD56UImJ6stIXjhDyb2cKuonk=;
        b=OTXX7YUnCYhrg1AwTXyxej5XtK6qSMAW5E6Pnnx48K2lMGod0kyMc9Tfzx0+A/YQO2
         /wZbfVE4KfE6jtOm/62GgTY51NmPs++pVlc/zNY1CJxnIreB6l6GJ/DMhFBDh7xtbCwO
         syCskqbMTE3S00xjM02cggneEp9xgPNaZaavvjL4YRFhZOUvwzs3LVIdOcxHI9U6jztA
         znGqyqQAN8vndJKpH//bWCgytt+P0vKEHSZnx8DeTdIahjzNk6CVKiazLb4ZsXP8bzuM
         4gy+g7saZx7gOekMwrB5u90+sipTnxO8bLir7cjavgJbX7YnEkh+BAYyt3kHEh8Epme2
         3l1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768468551; x=1769073351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0HijuXWJpjwbVYBFjlsD56UImJ6stIXjhDyb2cKuonk=;
        b=N4lPHlGS/Jbeg6oHKsxwgz5g0Ku8CamzgBhaBkdAmhYeJQLnftyH6BNjSrUG5I8Uza
         yGvv1aFBLPcJt3DUnOVgfyqlSZ8alZFDU9zTXlzxXXzH7akFurbKER7LZ+DHSbK6n7ra
         EYIBDd+i9lEqjNvSRcVQc7RjujE72aJDoA1WbYgJbAyjQJLZ0fwZliXP4RmFEciuYRqz
         n3z0OubZ6XGKhiQs/5q/mGejN8v37rZ76Zns1ddkR/01aLt3oF09NrxIttnc0RXGuEcj
         gBNhXC31hsdCNjITSb/L2T5E4PbOafD1ABO476ssqT0czKrDe3c27ZEkurKqQddwzsAw
         cw8A==
X-Forwarded-Encrypted: i=1; AJvYcCXl0McemiAwfkOYbAOAfdxew/tGBRPsVEkRtVquLwE0+QFC0M2JJZkJuVIhW2V+57BSeybEaYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqxkl+Zw+uRUltoH8SQ4xPQFgISy6ZUqR3I4yJdahCyRV5jBEq
	urnvbutCj+sQx0nUqCT8y0HljhMAtNWlZ0XsQrqkDJnHycL8611gD/M=
X-Gm-Gg: AY/fxX7An07D3gfwxfvM50uzOiP1UEMw8txleO4IzSxDwgeBE4FH4yTTlyhwfNnXl74
	Jyux65NPNDmlrFyaOUtN6Bg+jo6YWgQbTT8CeysbupWClaKf0O58tCRkvuwBz+sTfs+W0tcwyNh
	dywpYwzVqPx7Qek2dWN2erSXTz8SEzcZ6sYeqyMo3pUKcEKjFpOxwF6qaFdg2+NnLUev7+3buxK
	trprCqVUOcNgnXDjD7cnRMIhIAEVmEMSvDmCS3/hXh12A23gIlRHoITcVu1Ldst1y/S3Du6vxb2
	7NSue0BWlflW3oacRwkXbEF2M74IU7i9UaTBo9UfxPghKPj/U1gnzCIY8dPyaEVYmwTtamMRLb7
	yq3GBny8FGYWfWmlouflJF4WOjtZ6Y80Mkimtm9/Vw4CooGOmXpg8i1KbAGbhuVl7vIlPDgxlqx
	eA2MTLWi4dkskuwDizdRPV8eOZMcs3bxA=
X-Received: by 2002:a17:90b:3cc7:b0:34c:e5fc:faec with SMTP id 98e67ed59e1d1-351090bdf07mr5514921a91.2.1768468550753;
        Thu, 15 Jan 2026 01:15:50 -0800 (PST)
Received: from localhost.localdomain ([64.114.211.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352675f8e97sm1554321a91.0.2026.01.15.01.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 01:15:50 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: kuba@kernel.org
Cc: always.starving0@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	quic_luoj@quicinc.com
Subject: Re: [PATCH] net: qualcomm: ppe: Remove redundant include of dev_printk.h
Date: Thu, 15 Jan 2026 01:11:23 -0800
Message-ID: <20260115091439.2216-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113190210.5387bde1@kernel.org>
References: <20260113190210.5387bde1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the review!

I suggested removing the direct #include <linux/dev_printk.h> because
this is the only file under net/ethernet/qualcomm/ that explicitly includes it.
All other files use dev_err() etc. just fine via <linux/device.h>.

But you're right — relying on indirect includes isn't ideal...
I'll leave it as-is for now.


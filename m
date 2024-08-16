Return-Path: <netdev+bounces-119107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB38E954116
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3500C1F250D9
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 05:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B2D78C7F;
	Fri, 16 Aug 2024 05:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1+9OE9c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92169EDE;
	Fri, 16 Aug 2024 05:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723785671; cv=none; b=g2UtfzlCCjQar4iMpjIvntu2AgzopI2R7hMdVm/TQRt3HhDrhpvt7Bl7ha8amR0qV/OOQ55BTD9pVJaq1oD6VqNPkahrJC2CG1R2v9IYHqQdzC/CJJvmAWxc9ym16Oc8QwRODnQXgoNmV3lTX1h8tO1XFwqjfkp9zrQz1imPGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723785671; c=relaxed/simple;
	bh=Q1StPvmYrIPDrCqVc1rknl7jqCQjLsJDaLzLSDzBkvg=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aI5TLTHH5mtPSht7nctYPT+/jdi74n6tO7ln8QhdibKiDRZnkNR4mn9SvKPMB04+nXNQBx5AyD98pROzFzQePT73C+weFIQ4BJLU9LQ3ESVhLyuZInuHLHdvWAk4mL6tPPuo13iC0y7cZyD880IMtL/H75ssuqybLWAFQvB4AIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1+9OE9c; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d19bfdabbso36975b3a.2;
        Thu, 15 Aug 2024 22:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723785670; x=1724390470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kt4MLjhHN1/ECVknyeMFc6dLTiAulkcnJtVT+D32Bcg=;
        b=f1+9OE9cnkct2fCOVam0nhA50tT/KHB2Wxk5Jlzk02VJ+znWkd4q13OoTuA/HS3dO+
         BpaUI9lb+i/pgPluKYrsQrMLGy407UuYcQGrMZYYijJrYQ23T+mxaerpGBKkv+8BtjoJ
         trMYTIvFuoczu/NICDblHvaA+QSrnCLm5GdMcufVEPvy5r9nJcqAfEaDJRqba7dlaFdV
         kSaEVrrgQD9619lRV1uW/TdUArpiH7T4Kn3lGyFNfUfOXq1cCT+91Nld+2OzhRnG5YW/
         MqwlNIxkVsCIIpf+P/42MA5FiFFz1xd+hag+0WPTFj5RquoMugK8QpGaxlaoXYWBKuD9
         5V2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723785670; x=1724390470;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Kt4MLjhHN1/ECVknyeMFc6dLTiAulkcnJtVT+D32Bcg=;
        b=uDK/cyJaNZgPH/DOuoeA5KBABSizVsd+IzuH7D8qvgof/2ThnoPqLPAGvVhAfV+F/n
         zw2/OzOxUYGGgPJa8MU8OylVQfkkHr2GnWqGboI4PU5dgqDRWEUwV67N0x5bYWr4u0zs
         1lCyepX3368896D5X7YF8PR15HQAqLGvSAMqwqLExwEUCszKbAFnU7zybdd0CwYFIr7Z
         jST7SgQYR8EBcU/dhnL1yP6qymNCUs0Gmlw4HJBgCl/j79F9y5WWbT2u36SXi916IFPD
         iV22WtOVvWwYOHBxMpCQVIZgIohPmvYpSTMvNqhbMfJZR34MjrCTjvRLWaMZk8+LYNcE
         LCqA==
X-Forwarded-Encrypted: i=1; AJvYcCUgftBe949AJkE+rfxmFhB6rnEZT0MgX+w1ok/JPlaaUk7jcUmfXqWOKaIosVwlfDbIroVT9OL8nRbMPNLuag5yg/cTs25sCF3PmvMdk9b7Vd3KgHWrEFhhCRVA6dwfLo5lJ75W7xo=
X-Gm-Message-State: AOJu0YwOcROMRQa3Z3HN+drnB0cRolhpDz61lD9BEfDF41Tb8l6UXWf+
	w76OyWq6Lt0gPJayEkrv1kfPjJDZUD8VdvyuQ7Orghgxm0HQRWYzPk4fTmzL
X-Google-Smtp-Source: AGHT+IEozBvUEpc3aKQfOu8vFKNPgrKEPB+3Yp6nU10Ft4nyWdn9A/ATnBljSD7Qa0O42VO2lFcHLg==
X-Received: by 2002:a05:6a00:3e06:b0:70d:2cf6:598 with SMTP id d2e1a72fcca58-713c56ae134mr1249619b3a.5.1723785669641;
        Thu, 15 Aug 2024 22:21:09 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af1bc1dsm1922208b3a.170.2024.08.15.22.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 22:21:09 -0700 (PDT)
Date: Fri, 16 Aug 2024 05:21:05 +0000 (UTC)
Message-Id: <20240816.052105.1315142429490875559.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 miguel.ojeda.sandonis@gmail.com, benno.lossin@proton.me,
 aliceryhl@google.com
Subject: Re: [PATCH net-next v3 1/6] rust: sizes: add commonly used
 constants
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <6b12ed3a-d846-41ff-9821-a3946bb88378@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
	<20240804233835.223460-2-fujita.tomonori@gmail.com>
	<6b12ed3a-d846-41ff-9821-a3946bb88378@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 16 Aug 2024 02:37:02 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> Your Signed-off-by: should come last. That keeps it together with the
> others added by Maintainers as they handle the patch on its way to
> mainline.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Fixed the order, along with the remaining ones.

Thanks!


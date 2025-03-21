Return-Path: <netdev+bounces-176708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244BEA6B8C3
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F3B3B2661
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 10:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8E1E47C2;
	Fri, 21 Mar 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="IonKT/Ot"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D2215078
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552830; cv=none; b=AONI0WmN9DFW5/ih+1O0i7n60He7y3PgFPxk5uLhL5OqdOFNvRMx+eFFfOPr+/gHmxvCjJqDKUTKhHqfdDdGsQVctTyPGvK7hodgTDpW4Ak6+1ILAP89mmB1cutXO4VYTVJyY6b9dcFcmzfKumgsAzqAZGoPxWJei2MnqDELQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552830; c=relaxed/simple;
	bh=UZmFI/DyutG1aepD1inleyURUrFKq5azemtKpxgftZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DPaAZ3uytPmduJM+rlTR4308zx4Uf/JWjA6LAkpvsk+eQNzxPLo2gSinhDQVcx7JeLY5HqvAniL36SnwTTSFUXyHu4nYjW39abcW3wFH3zW/8T6/t+oZcaVVamo5rh2BaxbxjJ46QxIp3mFgUuXWeFkS2u9uUu9yV9oNNSz1/rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=IonKT/Ot; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ac2c663a3daso366439866b.2
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 03:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1742552826; x=1743157626; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu4i5eqjru7PimQLCqcGFqR9RCZeXfEVJLVFfQmDF3Y=;
        b=IonKT/OtpEdWpbkzs1EI9+6CDy4cJ6cYKyAlzSrU+oYAXsV5Sj9ruOqlANmcbdMpNq
         tHu94qKsPpaFdG9kDzKFkjTiM1JNtNOk1yq/tHUMZeGVseBpZa2RSnU/3V4qt8jCAjvN
         LRc6seUenvHGpzbQeXklDhNPPVrgjf8s6y7Umggngm48vw0e5EtgNAuX+7+Ui1A2/lCo
         QPlTbIBEnrVJdeAdB8wLw24pl5JY1aW677f3Rguqh703rnE38qIauIz/bqCZfMprVWMp
         SCiTz4uOhpwYfVqO8mbQBfkl8U4JW58Fhn7Ot98RI7Z6saFSBxeklylREA1+N5k3MPOD
         aPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742552826; x=1743157626;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wu4i5eqjru7PimQLCqcGFqR9RCZeXfEVJLVFfQmDF3Y=;
        b=V8CweilkM1rOx5Al8YSdA/2klai+95g4w4kPnqex02XvQhQNpJIDWYn5rGppuUKVkT
         CZX7UVc70b6NAEmyLQ/ZIHhuoc3K/cRIYLCPV0F5XdFAQ9hLx5nxBlSYaOSCVldMY5lg
         MLNYLpIUIMyAWQ/0FlqpiuEhm2OOpFnTqZa1sBQXjUYS3mnY0qouH6XYPkiM9nvcnWCJ
         DjAior360+jGcD7FDs2KMqFtrkCOUrS9V16EMSIjBaTZvbORqirEbD1AgiiR8PLjGUNo
         6e/udYhng5ays/+YDulAjeUJHz0n0OZVv4bvAfRwKNz2zl36G4DqiDT+IfnHU/gcVx4J
         a3gQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW4QbTwuq2PT5Wv2tvL417Pjc06h4buUm5keRgCzTi1XJs/c1EdNyPWB6JBlMJpuJf3XTdVt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+z1BQvkg02QgtGLfFIV1lFLuA46d1E07u9Tq+edz4hBwk63e
	H8/axjXsbzuKCKv4bK2XgFagNLWs51snYnvEb+q+pyhqeRVhaTgCtrso1voi6voEXah/OAkUISG
	L
X-Gm-Gg: ASbGncujRCmaxULVEM8VMYLP63GzbG0qVZ5nqnHcQskqcdp+vVgVeTpMCmBp2aQYRDW
	96iGHyL7FQB2vEUkWWJxM0tXVF2W18oZ7U7ByT5lKG8lfFbDxrzQZjqB0bCcFcom9KpOJPZ/aCv
	UDWkwH5LRbtWNzqH2kUFN5nGx7kbSfSM2PFpakeZ0U25meIgx5kaDDpKFh1DN1v92PUL8OvJxOy
	XhzWR9Yl1hR/h6dRPLwOeq4P/q6ycGX3eEdlj+WqlmdaInvfljPBHCrpXGpaNBNJz2ddGRQGjKr
	mB51nLKmjaZ16W0pmdg9oY7WtfsmweB0uvAjGn0BDA4cnAJ10hCZmTvGF69fP+GTYWuCL1hYYYE
	=
X-Google-Smtp-Source: AGHT+IFUV57GRhkoiFK2QLz02CVKRzzXrPOpX1CQUTZ3dFxIy7zKzGTfXLxUvljPSVlo/c/udERyuQ==
X-Received: by 2002:a17:907:3f9b:b0:abf:5266:6542 with SMTP id a640c23a62f3a-ac3f2539879mr199078566b.55.1742552825817;
        Fri, 21 Mar 2025 03:27:05 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd4d36csm128037766b.170.2025.03.21.03.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 03:27:04 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, kuba@kernel.org, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net] net: mvpp2: Prevent parser TCAM memory corruption
In-Reply-To: <20250321111028.709e6b0f@fedora.home>
References: <20250321090510.2914252-1-tobias@waldekranz.com>
 <20250321111028.709e6b0f@fedora.home>
Date: Fri, 21 Mar 2025 11:27:03 +0100
Message-ID: <87sen6adc8.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On fre, mar 21, 2025 at 11:10, Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> Hi Tobias,
>
> On Fri, 21 Mar 2025 10:03:23 +0100
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> Protect the parser TCAM/SRAM memory, and the cached (shadow) SRAM
>> information, from concurrent modifications.
>> 
>> Both the TCAM and SRAM tables are indirectly accessed by configuring
>> an index register that selects the row to read or write to. This means
>> that operations must be atomic in order to, e.g., avoid spreading
>> writes across multiple rows. Since the shadow SRAM array is used to
>> find free rows in the hardware table, it must also be protected in
>> order to avoid TOCTOU errors where multiple cores allocate the same
>> row.
>> 
>> This issue was detected in a situation where `mvpp2_set_rx_mode()` ran
>> concurrently on two CPUs. In this particular case the
>> MVPP2_PE_MAC_UC_PROMISCUOUS entry was corrupted, causing the
>> classifier unit to drop all incoming unicast - indicated by the
>> `rx_classifier_drops` counter.
>> 
>> Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>
> I gave it a quick test with simple tcam-based vlan filtering and uc/mc
> filtering, it looks and behaves fine but I probably didn't stress it
> enough to hit the races you encountered. Still, the features that used
> to work still work :)

Good to hear! :)

I have tried to stress it by concurrently hammering on the promisc
setting on multiple ports, while adding/removing MDB entries without any
issues.

I've also ran the original reproducer about 10-20x the number of
iterations it usually took to trigger the issue.

> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>
> Thanks a lot,

Thanks for reviewing and testing!


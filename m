Return-Path: <netdev+bounces-121339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3251595CCBE
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DA81C219D2
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83C52CCAA;
	Fri, 23 Aug 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yZRimCqC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4E18028
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417199; cv=none; b=KE4luqIRpqVujxO195KcLnT40uqBlkssJDp22hCk+/kE9rALBg9DJvaGuJFBCx7dL/1y38uRXfFKJAJLtq6V6bjkYdHKcGUhYD2uoJOvfreDi89RUpDvYEjItG0hMTtRrSsa0g5W5Vw4sZowuVQeusP90DpFfb60zkvRhNz3Ueo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417199; c=relaxed/simple;
	bh=a0P2oyB7nft7GsbdsKzw3jVLZX7UUuQX690Z4xGV20w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aWH5M84R8CPQbpw2xNNDz9jCNTa0W1tsAoc0d3/dJ+jDYhEBNSkDySuTlTHlEFdMcgSFVjZlNFfn30qWLjjx6Pj2N5yHZGd1B8zVXVQAapdiqJchGQH+6MowcfiuYdD9b/ThGMu8+ZhnUwxK7fTuThbOqtiCFCgMXRvJkSBAEa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yZRimCqC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8692bbec79so255220966b.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 05:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724417196; x=1725021996; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xNLm8u9gpoteg8u5TYjFfCK/O+hGsTxpjWhrUTYykBU=;
        b=yZRimCqC1IAhcBu4r9DSas7Hc//AVFyrqEPMhSKu397I+led4W4R02HZiDjT+NJPnC
         97n5DQsEPto+OlEMooJMjhTk4NGNNPJLiYv0syKJsIVt+v1YPq+IcPssdlnpzfMMARts
         SERGGNdZQXrbRMPuwNid3Xv2zh57l6dbshyI1d52HwGyv592NkazEQQ+b7nuaErDoURK
         qL45vqvkmsjnNDN/AwWEln9SrCPHJBNV5XK7GLl4/CkL4TodtNFqe5oN69yUyF915EMr
         swzJY87e7H/AgrjxZ4T2qAgI1GIq5Yv9bnhmGQ4BjCt8+HpKQEDXyBe1Hg6psg61HQP3
         lHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724417196; x=1725021996;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNLm8u9gpoteg8u5TYjFfCK/O+hGsTxpjWhrUTYykBU=;
        b=V0tg4uBNh1jNWbxe2S/wuSYmOU35+8m8J9Ni8hTFQ2o8w9eOsFqRx+nTY+hD3JgheH
         2MDQR2zCMY8PcTZNqv7a+03WV2IK8RWtvh1MGHRiNseTW1kRuU/xFWpSd18XAK5WHpHT
         m7MBRJoYk5w0lntFWeLM+8yKoAEkIuSc+vdScZtTZb1EyeP2d3NP96xQZGmUW0PghQE3
         EBqi2nvpRDIA15+v/X/yW0ENwshIW0NKnZYN5oNX4Ki9XzPa8NTJNd2eDVG+15TMwQJs
         Wpjk9ntLIrbOcwJ5JvWrpcshvmSzGbX6nezZxBlEwhu2tnBdeV3ayavO+9PYC/Pwe5YL
         A8zw==
X-Gm-Message-State: AOJu0YzRgTFm9mn7wBKqUrQuy75pJrIBX3tzkNfr70mbFXI47O7coBPE
	sRCL9Mb3geb7AQgdad1DPKgBA102f4/1yT+VNwqgVfPZET/kl0F0RM15b90G7djzG8ovyrlBeNL
	0WtMzCA==
X-Google-Smtp-Source: AGHT+IFO98iLEZ1MERbfpYED6cX711iVFsJXCbWg7hxOY6t5W4/BDiScNi+VlqjXElJboAz1V8bo/A==
X-Received: by 2002:a17:907:97c2:b0:a86:7c25:d468 with SMTP id a640c23a62f3a-a86a54899a7mr161871766b.52.1724417195841;
        Fri, 23 Aug 2024 05:46:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f45a5sm255316966b.206.2024.08.23.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:46:35 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:46:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org
Subject: [bug report] net: dsa: mv88e6xxx: Fix out-of-bound access
Message-ID: <d9d8c03e-a3d9-4480-af99-c509ed9b8d8d@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Joseph Huang,

Commit 528876d867a2 ("net: dsa: mv88e6xxx: Fix out-of-bound access")
from Aug 19, 2024 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/dsa/mv88e6xxx/global1_atu.c:460 mv88e6xxx_g1_atu_prob_irq_thread_fn()
	error: testing array offset 'spid' after use.

drivers/net/dsa/mv88e6xxx/global1_atu.c
    402 static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
    403 {
    404         struct mv88e6xxx_chip *chip = dev_id;
    405         struct mv88e6xxx_atu_entry entry;
    406         int err, spid;
    407         u16 val, fid;
    408 
    409         mv88e6xxx_reg_lock(chip);
    410 
    411         err = mv88e6xxx_g1_read_atu_violation(chip);
    412         if (err)
    413                 goto out_unlock;
    414 
    415         err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_ATU_OP, &val);
    416         if (err)
    417                 goto out_unlock;
    418 
    419         err = mv88e6xxx_g1_atu_fid_read(chip, &fid);
    420         if (err)
    421                 goto out_unlock;
    422 
    423         err = mv88e6xxx_g1_atu_data_read(chip, &entry);
    424         if (err)
    425                 goto out_unlock;
    426 
    427         err = mv88e6xxx_g1_atu_mac_read(chip, &entry);
    428         if (err)
    429                 goto out_unlock;
    430 
    431         mv88e6xxx_reg_unlock(chip);
    432 
    433         spid = entry.state;
    434 
    435         if (val & MV88E6XXX_G1_ATU_OP_MEMBER_VIOLATION) {
    436                 trace_mv88e6xxx_atu_member_violation(chip->dev, spid,
    437                                                      entry.portvec, entry.mac,
    438                                                      fid);
    439                 chip->ports[spid].atu_member_violation++;
                                    ^^^^

The commit adds a bounds check later if the MV88E6XXX_G1_ATU_OP_FULL_VIOLATION
flag is set but it doesn't add it here where MV88E6XXX_G1_ATU_OP_MEMBER_VIOLATION
is set.  Can only one type of violation flag be set at a time?

    440         }
    441 
    442         if (val & MV88E6XXX_G1_ATU_OP_MISS_VIOLATION) {
    443                 trace_mv88e6xxx_atu_miss_violation(chip->dev, spid,
    444                                                    entry.portvec, entry.mac,
    445                                                    fid);
    446                 chip->ports[spid].atu_miss_violation++;
                                    ^^^^

    447 
    448                 if (fid != MV88E6XXX_FID_STANDALONE && chip->ports[spid].mab) {
                                                                     ^^^^^^^^^^^

    449                         err = mv88e6xxx_handle_miss_violation(chip, spid,
    450                                                               &entry, fid);
    451                         if (err)
    452                                 goto out;
    453                 }
    454         }
    455 
    456         if (val & MV88E6XXX_G1_ATU_OP_FULL_VIOLATION) {
    457                 trace_mv88e6xxx_atu_full_violation(chip->dev, spid,
    458                                                    entry.portvec, entry.mac,
    459                                                    fid);
--> 460                 if (spid < ARRAY_SIZE(chip->ports))
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is the new check.

    461                         chip->ports[spid].atu_full_violation++;
    462         }
    463 
    464         return IRQ_HANDLED;
    465 
    466 out_unlock:
    467         mv88e6xxx_reg_unlock(chip);
    468 
    469 out:
    470         dev_err(chip->dev, "ATU problem: error %d while handling interrupt\n",
    471                 err);
    472         return IRQ_HANDLED;
    473 }

regards,
dan carpenter


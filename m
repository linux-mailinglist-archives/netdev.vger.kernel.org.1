Return-Path: <netdev+bounces-133802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEB699715D
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2474E1C228A5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562901A0B12;
	Wed,  9 Oct 2024 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blDy1WjH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20F0188739;
	Wed,  9 Oct 2024 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490814; cv=none; b=F9ivl4mmPwmHFDUkkcvoeKAcyfZjmm8tYNA+CxL1zip3SXLoHzaHhljD03U918i4QeX8HSuapCE5LR7D3LnJDqIZpYTG59wobidk8DPNMryet9GHvr6xdtwYAkjLwwX/zea6AzxbjxljHNrYfGzyQBsonChKXs8LQdZIfa7T3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490814; c=relaxed/simple;
	bh=lmbcAPGmgwt5sFwhuNy7eqrMQpYlkaIrSGYjWlrS/EA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CLBiXXzHjZ+XGqxaJxYHgw026M/TEucmwETyPtGAFnLHbOlo8eBKeezwNiLENsBOXkNPB1xDqJ5nFz9FHly+o06WD/39ySIq3Jjfuj1VrI0AG+MrNYPwVt2SoM++wB1rj906mdLjVMw+U8G1yX6UGEsxfknl0V9wfkA6luR4Ehg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blDy1WjH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99415adecaso196282666b.0;
        Wed, 09 Oct 2024 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728490811; x=1729095611; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cu6guiXNhmZ8pp8vns2UvV2xZW43TH5j7O1PW+OMNKA=;
        b=blDy1WjHmsoK6Q6DPfXni2UBVT7R6giiliLR7v+8rUzihfDWqFxp5xvO8WUKZFqEuW
         AhJOXakBwVtUBL40p4mOYQEZGP8gqVwNKntdky87fGMVkBiFb+bR0SV/0Sicatckkfye
         /F5CfMbku9JW8GBzhw4HIyx4Q1Cbz0RbTxWl7ZRPnB3Uq2MUCU58ji4tJ9aeU/6Beh5o
         6gXj8Xa3pLCiyZrEvZDKhaItAkDwtsojgMUTwczVfoJr2UVj4SC0TGIeoJEwxdS3Z9yR
         sNeS/1yl4BfXe6Odg9+wOU/Lh4sHudrxbyc2TzxoRxrfjMcl7I2HoeosgnLjvQPA+5WX
         UYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490811; x=1729095611;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cu6guiXNhmZ8pp8vns2UvV2xZW43TH5j7O1PW+OMNKA=;
        b=PbipLbQ/L4TWlEHuLf/Nreslllqfy/i1yPdIE1QAvryYCligc3uxSf83/flrEgyEHR
         BPLl9NVWjcRvNDL+up3YkFbljfWv8R9rWnpSqg/jQTR8iFYk5SQD0m3gILEGZ/2bUKDB
         xVuBHBI02Bn88YszM9XDKrQ4WhA1m0b3B3zHMbC9QgcEdMJsRA+de/1RV6b/Zywdln+T
         6Y/XLo0LqBggfVb6d/v7yCVNEnHIJcQIPfOj9EHGtL2JU3k0LkluaBkqEhWMnrNTdFNO
         81UYK66yjAHBDXR/gAkKIn6QwAwKpJOkOcPIkTzl0uEaw9Wckal7w82uCIiDT+yJiTnu
         tBTg==
X-Forwarded-Encrypted: i=1; AJvYcCVix4fvKkH4cxAPWbosmWMI6mpmyfuFf8/ObXGKApBlQfg92iwZKsnR7kL5SE1Lr6U8GkhrOs0attzdewY=@vger.kernel.org, AJvYcCX3Fi5UFZF3SsTlqKI+GXPdMFeuNwHw/impxQL7P5P6wv3VkSd5vubAVbSmIsuxZ1whQb87icU5@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9pXVBn6hIPD6goAJRUYI5ue8TRcBsYv4Hhq36ny5L6lySe/4
	j84XOVEIcHx/o0I+oGiHchFSA1QUS5OB18gee9Da0NiSO4tokjY0
X-Google-Smtp-Source: AGHT+IHbX0Q9JeAXTX4Nt+aILpTtZI843aU92le5ik7lO8DESn97fUVrdPig/+vBKwIdW2GLFoIwAA==
X-Received: by 2002:a17:907:8f16:b0:a99:4e74:52aa with SMTP id a640c23a62f3a-a99a113b8f5mr16249266b.33.1728490810719;
        Wed, 09 Oct 2024 09:20:10 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a992e5d0a3dsm674794566b.24.2024.10.09.09.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 09:20:10 -0700 (PDT)
Message-ID: <13c4d51e-7209-48c6-883b-661395798a9a@gmail.com>
Date: Wed, 9 Oct 2024 17:20:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: net: dsa: mv88e6xxx: Add devlink regions
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Static analysis on linux-next has detected a potential issue with an 
function returning an uninitialized value from function 
mv88e6xxx_region_atu_snapshot in drivers/net/dsa/mv88e6xxx/devlink.c

The commit in question is:

commit bfb255428966e2ab2c406cf6c71d95e9e63241e4
Author: Andrew Lunn <andrew@lunn.ch>
Date:   Fri Sep 18 21:11:07 2020 +0200

     net: dsa: mv88e6xxx: Add devlink regions

Variable err is not being initialized at the start of the function. In 
the following while-loop err is not being assigned if id == 
MV88E6XXX_N_FID because of the early break out of the loop. This can end 
up with the function returning an uninitialized value in err.

I'm not sure of this is ever going to happen, or if in this case this is 
an error condition or not, so I'm unsure if err should be initialized to 
zero or some other value.

         while (1) {
                 fid = find_next_bit(chip->fid_bitmap, MV88E6XXX_N_FID, 
fid + 1);
                 if (fid == MV88E6XXX_N_FID)
                         break;

                 err =  mv88e6xxx_region_atu_snapshot_fid(chip, fid, table,
                                                          &count);
                 if (err) {
                         kfree(table);
                         goto out;
                 }
         }
         *data = (u8 *)table;
out:
         mv88e6xxx_reg_unlock(chip);

         return err;

Regards,

Colin


Return-Path: <netdev+bounces-92560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F91A8B7E68
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 19:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7C3280AAA
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76A117F396;
	Tue, 30 Apr 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ci7kPrCc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7F317F37D
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498033; cv=none; b=hF5FkFbjbarbMF0Qo/T7Klk5ba89UO9JmVri4JIszd6+if72XWTf3RSJnw8XqxwoOEy2Duy0HBdGDK6fXKc/zJvuT+nl9mRtKI2NdwriEc7LLEc9GUOGjZRokYc0mMeVPzDIhjEH0Kg9kXgO2LRnmOPvtCa4fMD0mAjivVK3G6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498033; c=relaxed/simple;
	bh=WfOVphmhv/9DHaLLypxzpDt16DQPjYoxL2liVI8RywI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MzJrmN6VyD9LBOxAkBK9JV/hXBxQKgIsGCeK1TZ1ZDR3945icXHhjMhO07SO+1ZYyQ6F3sqUn7e0GnzgbPMckcOAE40rYfN+ePgUuHVhOEDqOulX0BoAEIocKUj1tcxIs/tWt7D1Wzy9vhLR9EM9oz7U51+7b2wbi0mIFB30k2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ci7kPrCc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a58e2740cd7so6585466b.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714498030; x=1715102830; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMCNHrPxdvDu2iKw2+IACr5wzMFDcOz53bkBnPvdl4s=;
        b=Ci7kPrCcCiE1TPAdUg9B65NofiY2xFYrUnIWWnQR42NoqJF2MyJkJxOSln8gXKv38L
         0Mu2/eUm80IWELraWckc+TwjN7r7qP9wP6fYQZS9bNZRdSFJFJsC5P67vu5pakXW2qHT
         5IO6E4xEThp6ir0zxTlAE3NSJJFQFq6r1NlcF6Fwb0gjBLX7CKjReBF2H56xdZ/MIZN4
         OZ2KDPdEHoZ2wsTS9M+H/j8VgpsLGKgCytQr5lv2KmjhpiRBfpWvJkq4FexscUvn82zS
         YBMHEaccUyMmN4wmR/1mQ7tqHt1eYpMlMGiUcFQR+kCb3DU6LDlHSLRqTN92tHS67jJu
         idJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498030; x=1715102830;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QMCNHrPxdvDu2iKw2+IACr5wzMFDcOz53bkBnPvdl4s=;
        b=aw1cHTEoTiL4zf8IBFLEVxG9ZiCKj0j6xjiyQuYCYPzvKEWVh8qYNAu5ZUiJ8n9o+3
         FCxXDUkhFQWfjMzj/Y/RM81tV6HGos10pJIGiGTNIUwOdKYgGJ2WaJXKCwUfULyGHqPm
         oeTCstYjV++9QZEkUNE/6Nc9vkluAAPEDKwLOvnwB6WviKZrF16rUBTZloxwv1myrnhS
         8+CVXYY+nxXkjsZ6TlhIgE4KXGNpqwwMAs5gjQiJa+bQVHYK+sfjrNRtjphRmlb9MXT7
         ZnR97XGpvsVyguF3SCD1kDN7JmwJb/LE/n4m7sILtlBqeWgldfHhKz/tPbu8H/0Qez4e
         FZJg==
X-Gm-Message-State: AOJu0Yz6Oh32PNpmUtVLVOAE/TE2NslM+cB/q5O+G7ZI+YrYxApZI7z6
	YLG31FIMmx/VuDGmqSo723fI9x8lTtoiqTNbU9IQd8bC2emu1CtcavSiag==
X-Google-Smtp-Source: AGHT+IElM2df7WCzabPBH0lUQssVB+SbUKQASCb29cJVKULJ12TsmrYVr33mWuPsxmH+pj/PFmLXjw==
X-Received: by 2002:a17:907:7627:b0:a59:43e5:2506 with SMTP id jy7-20020a170907762700b00a5943e52506mr250863ejc.38.1714498030077;
        Tue, 30 Apr 2024 10:27:10 -0700 (PDT)
Received: from [192.168.1.23] ([31.45.194.231])
        by smtp.gmail.com with ESMTPSA id ww4-20020a170907084400b00a51d88e6164sm15285638ejb.203.2024.04.30.10.27.09
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 10:27:09 -0700 (PDT)
Message-ID: <1055ba5b-7230-466a-ba6d-4bc946c908c0@gmail.com>
Date: Tue, 30 Apr 2024 19:27:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Content-Language: hr
To: netdev@vger.kernel.org
From: Antonio Prcela <antonio.prcela@gmail.com>
Subject: [BUG] iproute2 - vlan-ids not shown when -details used
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

the following bug has been found in iproute2's bridge tool. Reproduced with
v6.8.0 running on kernel v6.8.8 and v5.17.0 running on kernel v5.15.70

Create a bridge and attach eth1 to it. Set vlan-ids, for example 10-15,
set PVID of eth1 to something different than 1 but keep it inbetween the
set vlan-ids. Ergo: if vlan-id 10-15 set, then: PVID > 10 && PVID < 15.

Query the state via bridge vlan show:

$ bridge vlan show dev eth1
port              vlan-id
eth1              10
                  11
                  12
                  13 PVID
                  14
                  15

Query the state by adding -details flag:

$ bridge -details vlan show dev eth1
port              vlan-id
eth1              10-12
                    state forwarding mcast_router 1 neigh_suppress off
                  13 PVID
                    state forwarding mcast_router 1 neigh_suppress off


As one can see, the -details basically stops at the PVID and doesn't
show any vlan-id(s) that come afterwards.

This issue can also be reproduced in a standalone program that uses
BRIDGE_VLANDB_*, like it's within iproute2 when -details is used.
Whereas not using -details retreives the vlan-ids via IFLA_AF_SPEC
and that works fine.

Unfortunatley I do not fully understand iproute2 'under te hood' to
provide a patch which would fix this issue.

Hoping for some feedback regarding this. Might be 'works as designed'?

Regards,
Antonio P.


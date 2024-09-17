Return-Path: <netdev+bounces-128738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15CF97B504
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 23:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54279B24BF7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 21:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C4518BC17;
	Tue, 17 Sep 2024 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBsbVAAq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D761891BB;
	Tue, 17 Sep 2024 21:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726607465; cv=none; b=eUtPqJWzeaVzoju0FUFVjff0QSA590DgTpFhUDcDuG7bvFNUAU1V6HoS7J75G43uOcFHgMYBzdvrq14HXMefadE3ob4KDTEjzJdyEoYRoT7F3DcGiPuCEEGPvlaHN1xxpJr+X8cRSXkOTqX1pu3j53lAAjX4MPRD6IRiKI0v6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726607465; c=relaxed/simple;
	bh=oY7LP8m4kAB+OCiYtJk3+oBAX2lA1aoLzJBbYSqE8BI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=uKGONerHWQPFkUwKSx8JCYTtCXYbxs+hkf5K8M6hXnjqRcozUydq2NbdobWiLzRjQR8iPWn1eVm27WalkXVIc315jvcv2oqP0bZWiKs504dI+ST52qt9McMssAxIAe17Ie8C+lcZOrnwnN5ikkAB8Ipf6+kMYl6JMF+CobHBBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBsbVAAq; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso5856402276.2;
        Tue, 17 Sep 2024 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726607463; x=1727212263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THbtV4zkLuswYUTQFBFQ+ye5UYZZbQ5pAscYSwJszcM=;
        b=hBsbVAAqqvWqT1mYEo7qYWo2toLcJJTeTYKwSwnMzuZpHEJZPl34vX/8Xs4MEnFGZt
         KIKF5CEAfa5DF9y7lpnIo6A6qNF5c6qoqqa5KK38pdDW/FhZx9vAwnjjZ5IyGrQctVl7
         7fD8smqa4mbA8zxWnOkIXflCLQE+qullBaxpTyQ66ZAGABC4w19fuzuot3bFX5q3KK2Y
         Gtg3dBABRb/TkD7xEPyBXVs/tpLbNC2TJpQf/Qoa+7A5kSfPKgCsyxIyhIBjaOqyA5SC
         rBiif7wqkWbKkJ4yTqPmM9R92z7d8auDWfDzcOcgQw6iKD7ZfYhi/Kh95XBbnjYfVfzE
         NYZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726607463; x=1727212263;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THbtV4zkLuswYUTQFBFQ+ye5UYZZbQ5pAscYSwJszcM=;
        b=ih78Im9mjV821cKUxOwsUSBXy6h8SDgXLx3HtkJ0KIE10N6nASTwVhlp0rKbQdLGz7
         dk6y/vi/orHAS/2l5S0sFLuzV/7VeReTgv1CswKVbbCFmWlhWF9DwlUTmSeUPIw0JaZf
         XYKxZkYLswqBQEuxAELXB2j43XKdu/uRY4Ei1DWJoDbJ/9YfkgJl6faqKJcqCv+a7UT6
         tvoaTC6edb6z7l8NCZqF+gjWOUemaBY+9OFhVcX4EsflxFKAlmjQ07ovqnGvuXwQpGsE
         BirY52oaL8IMFBsnZ35Dy16otx1RzKCTojBtobTDa1FTpCSvDQuik6t/LMtgT/pq0Fju
         MkrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+zYWVQYRhwh41LdPUqaDVwuWnA/rJkeQ3xVxmAbJS5vLBiC3PSt460rhmmfAsCv78KHc2kSrIaH/DK7I=@vger.kernel.org, AJvYcCV78r4EVQwwCeGng/VawPURVy/llYnOe6FnBzsWT9XEDo1kxQy7XMWdK2KalKiRmdZx0ALuX5K5@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1Ub9ieh//Ll6Hkl9GCWNrmh1nQgdCo/Zz5lKPbe88ocRmMe6
	TyJFPXRg0Q+aF2f4s/ymzxjDP3XgcKqjxF7N2wzGU+jw8Vp4RAO1
X-Google-Smtp-Source: AGHT+IHAYuBgWqQRSDzP7XBadSWPcSsJWOkdYtTzfRXK5jkk7pyHN1Z+cBLbbh7Vge0pwYUJtlYwjQ==
X-Received: by 2002:a05:690c:470b:b0:6db:da26:e8c6 with SMTP id 00721157ae682-6dbda26eca3mr95063987b3.44.1726607463269;
        Tue, 17 Sep 2024 14:11:03 -0700 (PDT)
Received: from [10.0.1.200] (c-71-56-174-87.hsd1.va.comcast.net. [71.56.174.87])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ddbf87c73fsm12217157b3.117.2024.09.17.14.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 14:11:02 -0700 (PDT)
Message-ID: <fc79c53e-a5a7-4ae2-a579-83fefea772c4@gmail.com>
Date: Tue, 17 Sep 2024 17:11:01 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+e4c27043b9315839452d@syzkaller.appspotmail.com
Cc: alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org,
 dust.li@linux.alibaba.com, edumazet@google.com, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 schnelle@linux.ibm.com, syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
References: <000000000000d26462062079b885@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in do_ip_setsockopt (4)
Content-Language: en-US
From: Ananta Srikar Puranam <srikarananta01@gmail.com>
In-Reply-To: <000000000000d26462062079b885@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
2f27fce67173bbb05d5a0ee03dae5c021202c912


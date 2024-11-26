Return-Path: <netdev+bounces-147354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB159D93E0
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95675168039
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5281B4147;
	Tue, 26 Nov 2024 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ESg24v7o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45971B394E
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612411; cv=none; b=XCKb8anC7KyI0s3jqy4lD7zl6ZT6xbEQDC7CDRyrPI8ICQEGLptA/obiY1wjI40mhHOgllBg5q+UmZmfhQ8eaZ8GjRLfFYtuiSMDadpGtpwLEx+iYLVLVVWUOeWI3P9XlcCPFhC7SuOqucUS684/CglM55A8WFONaZRm6FoN5Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612411; c=relaxed/simple;
	bh=CsbZ28X3tP4QJFN3nurdyAAkbNcTudhsz38xFjwoTBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBArV0Hqp0vmvLuzZSy4w8lBti44fKtSc3GZfXEyme0lZJ0xV2QqLb9szyTXv0U4OaawNd2y8IB2rTaGyvP/pPXevdVQGvptbJP+8uJbStt1o+AbfSeQDg9eKoTq8ZoOxUdqMoPPJoWoPds6dFl4yoXSUytXnMV8xZYiZ8TJ8ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ESg24v7o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732612408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V99pFvhNgiMUcl2l0eAcTsg6ck1zEiuF3RXoVuVQE9o=;
	b=ESg24v7oJET2ZM2GZHKIHgj1RJ/qKSNtM5QsLO4mLBGa1NfmwDhFPcDKU/WTItprzsqBN8
	xGHUtd4nl2ot+6gagWA2oTvlOKgfhWcDUSTM5cp01cV21WbLVt2FMiGOMnNgVBhrzRvYAp
	SnVXkwkL1axs++mGYANebA+JS7b69ww=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-yevVLCWnPBu_1u_W9IQWSQ-1; Tue, 26 Nov 2024 04:12:22 -0500
X-MC-Unique: yevVLCWnPBu_1u_W9IQWSQ-1
X-Mimecast-MFC-AGG-ID: yevVLCWnPBu_1u_W9IQWSQ
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-53de479ec3cso1196493e87.3
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 01:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612341; x=1733217141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V99pFvhNgiMUcl2l0eAcTsg6ck1zEiuF3RXoVuVQE9o=;
        b=a+0ZQrvAc8HkIMwBuDGG/DIun+uwBfQdymDRaPR+Uznpqwa2fy+9f2WYSR9faJCINS
         PrX/RmD4E8lva00N45Ap3a4d8wvLI0W5+BAHi8uFaZ2ZsrNNHDvHvghN/Ao10VePiaKL
         tbGX8R9CMtR1mvWDmwNssjtupzdHjIfZ03zbolgtaAp9ba7GHDGB5CtDa1DK1+7TrW47
         fnpJMdSEKyq9sP2mYAaDuBCccCcCjn1rVLaX17TyrTw659ClVg3ZTT+1dwB3uGjIWZMS
         GyV+KFq5OR47OGNiH3GT4bWnlRRV2CRM0WQUPNKaiFx2ztMK474UJAoh05sx1ap1+NfW
         7p3A==
X-Forwarded-Encrypted: i=1; AJvYcCX2QxAMeVMsmxcW7BTvb30nAjWXT3fDIBotsa3TQibXb9tATdez0E4lZp62Yt40gjkRWR+V/QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYi1cYaAqiK0DJZ72+/Tmuy47UGbwjkSiHF+pEqT+jCCrK6Vrr
	hlrH83x6o1HN/dQNfo79lITp/M9PA/G1LE0TOA/yep8/Hj0AjrGDBSYNfscMW8L4TcJJbKaLP9V
	LsKbU4BXopb7cg2jH4jxe1TrWrjgqqSgGDpc97dTsDW+g/yLJVCzq+w==
X-Gm-Gg: ASbGncux5X/xZEwf7kac3Ix/nkZJjRmbA3lp3iB36OFSPfknwHIZE9wmiOFy6hRh0aU
	ZygnbiSoms9ayAw7lWbQe/1/d9QdvTh3/RWxuyWStAPTGXfF+Du54lD7rbyl4PgAj7qqltKD6y3
	qQs9ICM2x18imrg/KVMyZf/m2/bQ9KC3TBUmZdLEzqfTer8XE6MYmSwUnCcQDrny7AFQrxw+m9k
	tAjXB4PLH4RZD04mbEdLcaftBU1GUhkXI3/lt0DhTsLpNPeD2VE7UnnEN9aywIL66NSxbVMgAkU
X-Received: by 2002:ac2:4e09:0:b0:53d:e544:3fd6 with SMTP id 2adb3069b0e04-53de54441a9mr3348084e87.56.1732612340815;
        Tue, 26 Nov 2024 01:12:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5HwldS99O3ZAEDUq+f4MJDYeNU8gBLmyj9eZdMjoxwaKTjy/KM0iGuvHYmTrG1iI5aRzXhA==
X-Received: by 2002:ac2:4e09:0:b0:53d:e544:3fd6 with SMTP id 2adb3069b0e04-53de54441a9mr3348066e87.56.1732612340420;
        Tue, 26 Nov 2024 01:12:20 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad60b8sm12654879f8f.17.2024.11.26.01.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 01:12:19 -0800 (PST)
Message-ID: <29d8c41d-ea21-4c35-9ec7-e7d5ef8aa55c@redhat.com>
Date: Tue, 26 Nov 2024 10:12:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 3/3] rtase: Corrects error handling of the
 rtase_check_mac_version_valid()
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 michal.kubiak@intel.com, pkshih@realtek.com, larry.chiu@realtek.com
References: <20241120075624.499464-1-justinlai0215@realtek.com>
 <20241120075624.499464-4-justinlai0215@realtek.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241120075624.499464-4-justinlai0215@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/24 08:56, Justin Lai wrote:
> Previously, when the hardware version ID was determined to be invalid,
> only an error message was printed without any further handling. Therefore,
> this patch makes the necessary corrections to address this.
> 
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Note that you should have retained the Acked-by tag provided by Andrew
on v3.

No need to repost, I'm applying the series, but please keep in mind for
the next submission.

Thanks,

Paolo



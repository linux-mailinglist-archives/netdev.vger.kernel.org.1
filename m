Return-Path: <netdev+bounces-184621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C53A967A5
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10497189E4E7
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC95D27C146;
	Tue, 22 Apr 2025 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWcFa+NU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90927BF7E
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321675; cv=none; b=Y0fJ25OtgpKq8b9ineuCCR2mF37cQcNj7q+WyL3d8PEAiDqTLK1Q4ni28KJPwRxP/LpqPkI/4EGJqLCm4RmYd/tCp5cjgsrDBkB03HD1KuiQhc0aFvgOks81KZx+6DGLTslCBgHhPXaAoUL5pWc7qFUSP9f2yc4XBG0opLtWbF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321675; c=relaxed/simple;
	bh=lFumZS6tt4BMr7MTloOs1i3/oR/EXnRSIqWU3NsWGDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk+MJJ/J/3o2If8FGZC5pgIqmYvFdL4y3gJ/nMTfBbOpZ42HVV2kT/U7t98/e/I1NlH8lT6PABJEG2RhFNy4pMDYp+VqCEFcsmlfuOPVBiAYZsNCwtLaaDLrDP+M9D/foVXi/7h4fZkl5l48w9vGPXlqUmCik/yyTBOWbKEK4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWcFa+NU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745321672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U00RFHj5GcnU7nOzmkFGCrDuJoVathVhZ4H2BEj+k80=;
	b=FWcFa+NUqAZtCg06Ob8ZTo45nmJNrhyaUJERn/T5C3KaQrL4azTD1snOagukLk+9+VShA/
	OZGkEy7r6UYJGI7TM7+j8LgxjJ0HGD4VK1fQfFfBAzgmI3CYueAiHtzSEX5Ofbuzj+dYCi
	QeYKcbNze4mO5D+gMzOEXhyu7L1RfDg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-xaD_QG8wMLa292Lz9RZkIA-1; Tue, 22 Apr 2025 07:34:31 -0400
X-MC-Unique: xaD_QG8wMLa292Lz9RZkIA-1
X-Mimecast-MFC-AGG-ID: xaD_QG8wMLa292Lz9RZkIA_1745321670
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so30627415e9.1
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 04:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745321670; x=1745926470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U00RFHj5GcnU7nOzmkFGCrDuJoVathVhZ4H2BEj+k80=;
        b=FR3n4PFzpt3c5y1G3zUICY9XLRD6+4eBSeDJ1KhrcfDIAgOvmN2Yc9Iq8+dbA6iFIj
         cK72NOMUABHls/xsXUH0kLW9fg2jJSEFDX5X8qbE7QMFQmMaCabym9Hcr9wZa8CpL4Yq
         E3e3MWypYXZBCSl5s4RI1tLrsqpwwSroDRC+VfqmYMacoSePM1Qq51j6JjZw6QdsMSK8
         G90PrFLvLbk5rZAXv5U0A0OxqGelZo+uUONsotmUgS9lJ+Am6T9anIOHhY8vv5hi2O/o
         KFPBXn9MNzI86Zc43tfSdTVTY6+NcfCt4/6qYscucaygJq4ds+P3N004nJ45MobRLVWJ
         eV2w==
X-Gm-Message-State: AOJu0YwfywEAHXzZyj4AEf6dUPL5ISLcJICpR+HEzAYJDMwBrXaBZKFW
	l+JxKKkDsmLQh9gijEhzwzfI/KKkw5MZqP/1c9lfKwY8+fPe9yPYsnbdOkVonc7KwvOxzV9RMwv
	nnT6b2dqOw0LsLquD/2P9Yz1xI/mNJkyJmmpjig3+weTX6df3NRkp/Q==
X-Gm-Gg: ASbGncs4J38s9icL5AndSl7OQavVxc32WmBlJQqEmuvTDwuRwux3s3Yd2Qq3Mfftj1l
	X8YmEiwZUQivVwA5/LNgODbMwgDpJe3iIa/HpPy5LfFiT2IAS2pbKOyef4T8HBgyq2MZedTdnlF
	eXFzc7q2VoiwZDU2XJhkZLqDE3YSBOPA51bXI18CbKvQmIlS9d6UHxfQ4GVq+8GB41YEGYqrcoT
	GX7i64UdVp1jvCQECDFohByvOi4RgcalSLR6gvX6pqfZTgcZdd3Rxzrr5Ay0FXgntWgrZaJcxy3
	pdkpAxG9lZdwmT4aSY2CeJQpaaDEK+uYxIsK
X-Received: by 2002:a05:600c:a08b:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-4406ab96950mr151278455e9.13.1745321669793;
        Tue, 22 Apr 2025 04:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxyp6dPoiSPRUX82g/CemVVsglLJ9gvL0b1VuZmHuk27xeWHrQ7nlHlBJC7WOsTXBng8kufQ==
X-Received: by 2002:a05:600c:a08b:b0:43d:94:2d1e with SMTP id 5b1f17b1804b1-4406ab96950mr151278235e9.13.1745321669486;
        Tue, 22 Apr 2025 04:34:29 -0700 (PDT)
Received: from [192.168.88.253] (146-241-86-8.dyn.eolo.it. [146.241.86.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4408d0a7802sm10151805e9.1.2025.04.22.04.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 04:34:29 -0700 (PDT)
Message-ID: <831f64a3-1421-4d61-a2ff-3ac17378c2a0@redhat.com>
Date: Tue, 22 Apr 2025 13:34:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant enqueue
 cases
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, toke@redhat.com,
 gerrard.tai@starlabs.sg, pctammela@mojatatu.com,
 Victor Nogueira <victor@mojatatu.com>
References: <20250416102427.3219655-1-victor@mojatatu.com>
 <20250417090728.5325e724@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250417090728.5325e724@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 6:07 PM, Jakub Kicinski wrote:
> On Wed, 16 Apr 2025 07:24:22 -0300 Victor Nogueira wrote:
>> As described in Gerrard's report [1], there are cases where netem can
>> make the qdisc enqueue callback reentrant. Some qdiscs (drr, hfsc, ets,
>> qfq) break whenever the enqueue callback has reentrant behaviour.
>> This series addresses these issues by adding extra checks that cater for
>> these reentrant corner cases. This series has passed all relevant test
>> cases in the TDC suite.
> 
> Sorry for asking this question a bit late, but reentrant enqueue seems
> error prone. Is there a clear use case for netem as a child?
> If so should we also add some sort of "capability" to avoid new qdiscs
> falling into the same trap, without giving the problem any thought?

AFAIK netem use is quite widespread, even outside testing scenarios. I
suspect preventing netem from nesting under arbitrary root could break
multiple ("unusual") users.

Cheers,

Paolo



Return-Path: <netdev+bounces-269996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHSoAeWDvWk4+gIAu9opvQ
	(envelope-from <netdev+bounces-269996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:29:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 714752DE9EF
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 820F53138CFB
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFE73CEB97;
	Fri, 20 Mar 2026 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgM8RBFS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2C3D0905
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027461; cv=none; b=T8Z8YKVMTu5q2K0YxUt3c5dh2o9QA8hhTOfFSe5rrNE2/vQAyHOx09bdT14QWBMbp2HW7BW6UI5D/vMTYEic5pthszGS2VFVLa7vHBpeXd6lEkOUWmXGHgn+jrbuF711y6ms5SQqnI7ICkYQPwt4tqRd78Ht4cL5fRSNzcaP5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027461; c=relaxed/simple;
	bh=wsmTnk81qY4dZoUf8M2YmiGOl4GG74Pq87bDkle1jHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Abpb/DVBDU/cBgMegtyxjbCr7REk14VeaFuUMptyKBoz2hiLMZJnguvCfOeoNrwke18Wd/FKCNUDir68bw+MXy9g+itHCCGSz0BYTGcFCupnMZWPAFC3NLfWSHnBXwKJ75imr2j/nACiGiUacgvec1eyA65NEeowyYC3l+wi44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgM8RBFS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fba7ce4cso15543415e9.3
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 10:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027457; x=1774632257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yw+YBmUR+wFyaejpDUu1Z5+Dr5WPXPB//Fj4vKcC1uk=;
        b=hgM8RBFS9qX6qCsJWHlkQP3vp0lo6uBY6wtLy8deXU2qAoA2xPxWDTctBamYWaghNA
         Ezx0IiyJJFEmxNze3JpoY2/IYFzlCh5YEKBBCGihMyEADtQA8doJYiVM8mmxd7wvVQob
         UYEs6KTfHV6Y7hq6LqNWr9Yc8c0uzRr8/6Mtq2H25OARNxPoMBev2Zh4dPJnCMAjMqLy
         bR+e6tt5nnd9Sr7FUFRzN2BzRQkx8ihoH+WDG/b9cfpKmJz0KWiQAWig7/j6K3qJeoLG
         IZrs2vQL5MS7CgAqStfBKHuOWVtLmz9NDcWxNBgUDbT5kNwHde3zmx7eQA/+zA1LUXxT
         C4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027457; x=1774632257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw+YBmUR+wFyaejpDUu1Z5+Dr5WPXPB//Fj4vKcC1uk=;
        b=i1mN2xJcjSMlEHeGhsTcAF7Nk/WHEXVCVcUny/lPsSIPWkVbCjnz+Jq7WS7i5aVaHJ
         O5hg2IEZBJlp9Pe+fSc/YzGB0KhjrEzkoMfBwVGj2gidUBjGpcLrYKTfJga5hKaVWF5W
         7Ad7haruqYzGwfrgIUy3lRalBjwW9kY14F8JU/nXN9wK6qL6/Desynnp5h948jZbKqGB
         gDZrPYSTUUe2JQS9dUGJt3+8raa5/VIhw3VzMY98y9sFESqZnPx0e2eBsssRJIv1Z5y2
         9EMM4OK+K9reDsV5XM9vtSlrcuhW/CAg8EsdFbwjLDcC+JkJ1l9lQqkBQLjkw6aXQiIm
         89Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUoksDT+NBAweMyiGSkXWcTOCJUGJftKBdf/nqgSrJSG0PySP4fQOSbi+dc2/ERyj1Ke9kvQ24=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyenJcZb7N5btTccrmcU13CEPFriqcF8Y5jnUSmrIDM0klikyK
	hYc3MNKY/fqQqUilEfs2pRPhJJpXSahcRWOp2ec57dolJSMs1/3rbbnk
X-Gm-Gg: ATEYQzw6Q81vwxJaWLDZ9qLlCCnErzk6STreBOM9yP3FTnYmAtAMtkSJdYWyPUtm3ak
	U8U3vZhjJQAFJ/qN3yU4BTu94VI/N+hP1sDJ5xwZiocqzpuObC6x+EQ1oGJzeo0dSsaCdU63kcA
	AxKT/TWvgpfl+3UaIwLKqn3tce7BHiutQARUtmG8SZz9diAai0N88aN3KMIKaUgAXoxGS2YFlOt
	v3/jl7t2jlrOlw3aZk8vbm4UVh+3lBNDELO2i5DyFLnt1PFiqkZ+unBoKRl8vNp3zGRrTGr0roz
	sUJBp6YPlGMIbHHxDzdu2/A3x6xBHNPPu8I//ZLWFHfvoc3SpOIeiAMFucIgIEGMqXXlfLKluwC
	spRdTGxOhsnv++eH/1Cgwi6I4Hiwir9PGcZ1rwyFO/7TsRpBTz2eP3hXGRzUejEafhLFD9TgEYi
	h+br+DD6DcPoqR/7b2XPE8YHVMEdssitKS7w/CRqjgZXyhpOyfh3fwfD+EoZV8ezYUWo4jkLJbD
	tdNdQggFMEsSQ==
X-Received: by 2002:a05:600c:8215:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-486ff030a77mr54538195e9.26.1774027456678;
        Fri, 20 Mar 2026 10:24:16 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8ba4a74sm148279435e9.12.2026.03.20.10.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:24:16 -0700 (PDT)
Message-ID: <59fe77d2-71e6-4b36-b8d7-0e465c7f5ab4@gmail.com>
Date: Fri, 20 Mar 2026 17:24:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 05/22] cxl/sfc: Initialize dpa without a mailbox
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-6-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20260201155438.2664640-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269996-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecreexilinx@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,huawei.com:email]
X-Rspamd-Queue-Id: 714752DE9EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 01/02/2026 15:54, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DPA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile hardware partition.
> 
> Move related functions to memdev.
> 
> Add sfc driver as the client.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>


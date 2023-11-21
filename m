Return-Path: <netdev+bounces-49779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C617F36EB
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 20:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1E291C20BC8
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 19:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C0142058;
	Tue, 21 Nov 2023 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEkur83N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DFE199;
	Tue, 21 Nov 2023 11:46:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40806e4106dso658635e9.1;
        Tue, 21 Nov 2023 11:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700596001; x=1701200801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KmH1+oaDprV5Eq23Jd2f7MjoyGQpqNp4zftRYgnu+Y=;
        b=QEkur83N1jgg/ZMhrqpfzPMeScPgsdF+XPiedHLAD/EcahhcqvCwgaCtUnDSVL5aRQ
         HYC9KyKMsuoZq0G/fha5PTWit2eadY4pKWQbip+OnGrHPLPXefETWw6LG0T7W4K87ufx
         bD8wEkNX87ZLNANbarL9CZzJJW437u2zEZZV7td02upvMKk37MD88Cl8HM9DiYw5KuSt
         +tQ1CyXDXTNlC8wV40ZNa+ns+PWaiws+LX0AgLWAC3XCYzrmquagQzh3bgabD1HL2gZS
         /x6nabsULTa4dCKP5M0We8XATKSP2k8RN8zxVeyiNVMW/RcM416r5vmnp9o/qJfNoLtR
         zmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596001; x=1701200801;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8KmH1+oaDprV5Eq23Jd2f7MjoyGQpqNp4zftRYgnu+Y=;
        b=uKE2SXFOJnq/eFQHfxBiJuB4p2luhpf9TJV2n44xTiarnEPGQMYMa2vrr9VfuI6fUz
         eQ5GBcKsM4hNoAC8KyKYW03UDh0it5OC0qcb7J6y2EVSf7thw6IScJ6He8ZKcao9sXpV
         7qoug2GGoClqMmJLNAyFRhjhcMWwqdMlYfB+QUdpiULjiItrU/cmFSq0apPbefbI4gex
         uhErlKvmfmSiBHirfvj0nFrTt8FE80NRoXTAT5CBOA3iNjGZEp528Uc9iOxu/7pftwoQ
         OVEkGAoes0GzMwNXBXxYFdX00yyP89feYagVIDbCgNgbgKY1YkBRHreu6xY9m0rKcYd4
         YLdg==
X-Gm-Message-State: AOJu0YyJTkoZwP5wvDB4jykinlulbnEUlerN45wu8tdgiU9eGQKAnP9e
	tKcBA7wP73BCsGn9eTvzJ9c=
X-Google-Smtp-Source: AGHT+IHxUA7uZNyyQ8/99NcVE5JVL5kMKuuqWLX4uFZmbAk4bkPXh5GfW5KFXOoT/Ohxo4ZKCBFDnA==
X-Received: by 2002:a05:600c:5195:b0:403:aced:f7f4 with SMTP id fa21-20020a05600c519500b00403acedf7f4mr3308027wmb.12.1700596000450;
        Tue, 21 Nov 2023 11:46:40 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id fb11-20020a05600c520b00b004076f522058sm22349575wmb.0.2023.11.21.11.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 11:46:40 -0800 (PST)
Subject: Re: [PATCH 19/34] sfc: switch to using atomic find_bit() API where
 appropriate
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
 Martin Habets <habetsm.xilinx@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-net-drivers@amd.com
Cc: Jan Kara <jack@suse.cz>, Mirsad Todorovac
 <mirsad.todorovac@alu.unizg.hr>, Matthew Wilcox <willy@infradead.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
 Alexey Klimov <klimov.linux@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-20-yury.norov@gmail.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <4aa03b21-5503-1d62-66b1-aa1b3c42011d@gmail.com>
Date: Tue, 21 Nov 2023 19:46:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231118155105.25678-20-yury.norov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 18/11/2023 15:50, Yury Norov wrote:
> SFC code traverses rps_slot_map and rxq_retry_mask bit by bit. We can do
> it better by using dedicated atomic find_bit() functions, because they
> skip already clear bits.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>


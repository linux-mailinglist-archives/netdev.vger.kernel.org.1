Return-Path: <netdev+bounces-53555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56806803AB8
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 17:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2D8281472
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483762D781;
	Mon,  4 Dec 2023 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrv/0gz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8DC103;
	Mon,  4 Dec 2023 08:47:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c05ce04a8so23781185e9.0;
        Mon, 04 Dec 2023 08:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701708437; x=1702313237; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LvTpQwaasVlCJl4p1fTbAgrA0NBuqainPf8SCtLi/II=;
        b=jrv/0gz1CxLSeH7gWFjHWyn2it9r2A93TGbTl8xjKTLGmdxOA9WT/rIxEH1eDbtFqU
         aXsWGq5VnisoNOVusAU8sox8w8Q5ztpLcZ3Geh990Q5BqWq0U7LXvDP3uEmzDoZsZ//Z
         lWG2hNfjkQDNjiwSq1M77Xymyp+vjGr86yp95+c1loV09QYdJwyFyLVbyb6+fUGVB4UO
         YsMB7uJSbMkTJijSTUCPct5dqvsAMJqgrdmyq2Q0uW9lDLdwQk9SopAnsqhZY2wtBLYh
         ox9E4A7Wk68cCJZotub4ICoGoqo8oxL8P3ppmSjum9WJMcmByzv1hO8UHYPIZr6EqVS5
         3Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708437; x=1702313237;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvTpQwaasVlCJl4p1fTbAgrA0NBuqainPf8SCtLi/II=;
        b=aLQKcT5bfepwidcBM3LoXev4Epok6MBIW1P0Z/ayNyAgeC9fJB1hpFVPskQYeb0nHk
         s8G+PGMsOJjOs3+xPTl3EwTtsAqk/0TK6XTx6YQGnmYCQFgqphheiNsZS2qK29zvJK00
         VxkTQ4M2+d4i9Wj5NI9L7Cn6L3G0rF8GNviOTiX20AgboT80nBsuqrSotd99kVXPkRSu
         QapVcf4OILiTR9+jEW95lRFry6wM826yMXFrrEcmMJTmvwGVIAGXRdi2zwxmm2Uwiakg
         BSFe6Kkvn9//L0ceT1GP4xnOfIy5Tqw9YBnnQNRlDCVGjaRj7LX9SEs2RQeTZD1BfFre
         bs5Q==
X-Gm-Message-State: AOJu0YwvWlizXlnA9ZQ3Of2MwolyUjYLyxdSQ0KWJ2jxZOvqqlIe+TtF
	WL4g3jUClbYG1S7oVT4P9H0=
X-Google-Smtp-Source: AGHT+IH/Jn9grVf+XLuvPauxdSXNWvjthStkrpARZ751p7/ukrIR2REI2bAdQMP6y3wyglar5AcvdA==
X-Received: by 2002:a05:600c:3551:b0:40b:305c:9ce8 with SMTP id i17-20020a05600c355100b0040b305c9ce8mr1288016wmq.28.1701708437316;
        Mon, 04 Dec 2023 08:47:17 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:d9c9:f651:32f4:3bc])
        by smtp.gmail.com with ESMTPSA id j37-20020a05600c1c2500b0040b3515cdf8sm15650485wms.7.2023.12.04.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:47:16 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  linux-doc@vger.kernel.org,  Jacob Keller
 <jacob.e.keller@intel.com>,  donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 3/6] tools/net/ynl: Add 'sub-message'
 attribute decoding to ynl
In-Reply-To: <20231201180029.45acfc2c@kernel.org> (Jakub Kicinski's message of
	"Fri, 1 Dec 2023 18:00:29 -0800")
Date: Mon, 04 Dec 2023 15:59:31 +0000
Message-ID: <m2cyvm6jrw.fsf@gmail.com>
References: <20231130214959.27377-1-donald.hunter@gmail.com>
	<20231130214959.27377-4-donald.hunter@gmail.com>
	<20231201180029.45acfc2c@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 30 Nov 2023 21:49:55 +0000 Donald Hunter wrote:
>> @@ -510,7 +561,7 @@ class SpecFamily(SpecElement):
>>        """
>>        for op in self.yaml['operations']['list']:
>>          if name == op['name']:
>> -          return op
>> +            return op
>>        return None
>>  
>>      def resolve(self):
>
> Looks unrelated, plus the 'for' vs 'if' are still indented by 2.

Yep, I can drop this.


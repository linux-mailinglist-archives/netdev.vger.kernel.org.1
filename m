Return-Path: <netdev+bounces-107127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ED6919F81
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 08:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D56D285CF6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 06:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8E52E40D;
	Thu, 27 Jun 2024 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFrO12MZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378C33C9;
	Thu, 27 Jun 2024 06:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470739; cv=none; b=DnA0QttWWqN3hXLxBwOZ42Wt6KcD+ZVGTmop8NQ6oR9JbmllQmu6GGJhMuoz573p9ZMQz8dfaF3tQjrWn+dQiiTv5mXU0xK/xxO6+ZEJ39xwlGLtOMoUMtqbE9qVt79UMk38liHp5mudKzpZ59aSryVvWZa3hYFqTQiaT1ZW3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470739; c=relaxed/simple;
	bh=QoIAkNrWrjC0y5N7eW7++/V0nwxt/I/u+sgkuqntuA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reAeyiCkgrai5SMvbOxusCibbDBHmqTcviUyq8auCU05igbPmUeF8GFa0NEzLlQJ3F+Ao9YHb8gbv3ZU2NmvQ2NWdxJnivf9BKuy5As1cgLd0fOMRbvLcKbiZUiDqFfjcND7paTmk0K/Mc44fOFaTTXj3yaeU9T8TbH29Py8z3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFrO12MZ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d2fc03740so1304865a12.0;
        Wed, 26 Jun 2024 23:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719470736; x=1720075536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRSBuGbR3tCWt9CEqfnOKjBBpsnBpX9oljTxmtO9ZxI=;
        b=NFrO12MZLB7YhNdizLwZzKpBIzP8l2v1OjGjmRUtb+VidO5skoRYbPYLCbJtDazKof
         3zGc6L48VhLl9gQV0S9mVnhTugFrCCq6T67WJiQxAetI2yfV7VTa/lXd49EgGDyT1KzB
         rqEduBnPVgHLEIyLyNucmLZ3X9fT6UzXdyr0pX2UN1iJvT6D102/SF65fdzixlUpxH99
         Syo4YNO3tTTlmEfJeMKgogS2OCNiL874c3bgLkyRqo3k0KJZJRHcZUXumwbDtpAxFwD4
         vC724ugVhf7DhZalkprOP/xPWBadt1QEHZonnjlMgjpMEqrbBtWGkgJPntQhr72OPPOW
         drgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719470736; x=1720075536;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRSBuGbR3tCWt9CEqfnOKjBBpsnBpX9oljTxmtO9ZxI=;
        b=rzGzb6dfPl0Sat2b1fwDm5y/CKjUUGPstIAeKIG5jI8KVFuvXmYaRbxomxv1EXgNjc
         LT9kqu46KUOxpwxBRXNZ0kjKDs/Y3mNfQCOJdOM/UGBKM35zgMkg/sje7OFrtzaffFgn
         Fcuihv9Bj2ARSVmvzwQFKPVLGGUo6vtcK8XN2UfBSdB8+WgEaSDt7rgxiZEv2/UdcuAv
         5iK2IW+byR3QsmHn+pHR8+yMg8rQgwwTSo+eD9uJcGRenPuhgxZFIbVqrPOHvFCLLf5b
         bvcIztdviSYwYlu++Y8Ctwhq4FJH/bycHq30UEfU32nz/fyWtNShuY3tNvYMXtFR4AyS
         4COA==
X-Forwarded-Encrypted: i=1; AJvYcCXmLHjOVK45e44ffJk8X5nJiuCNkTgU8BkL/3DvWRaeR4liFxhZrqdoXsAsP2Umo9m2erKDgFyc7qY1bAxKKTNB3UwNL4nrsX6aVTZbCBYEs2SJCm8pY+eCfRH2blOkcnPfmVXpuIgGyfVAx5pF9MXY4LU0FD0gByb7y8MfL1M//b5QKQ==
X-Gm-Message-State: AOJu0Yxq/hdv7qFYHTcoWzlCy5QPKfuHrUS78wyvBymf+eQmrPAEtytd
	RbOo0gt9mYvh5ejg5yjmlJEzz0YohpYXutNTxoawyxAfB38IA4Pn
X-Google-Smtp-Source: AGHT+IHWawN9Q/ebrV/rCy+L7r/1bBiUOSO5Hzzex0kjpOeNPpptFTHml7hK4YLJ70c6hSDfhL7MhA==
X-Received: by 2002:a50:99dd:0:b0:57d:57c:ce99 with SMTP id 4fb4d7f45d1cf-57d4bd5650fmr9144410a12.2.1719470735646;
        Wed, 26 Jun 2024 23:45:35 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-584d17b03a3sm455922a12.53.2024.06.26.23.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 23:45:35 -0700 (PDT)
Message-ID: <5c6426cb-8381-49f1-b0c0-34850759134d@gmail.com>
Date: Thu, 27 Jun 2024 08:45:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: bluetooth: convert MT7622 Bluetooth to
 the json-schema
Content-Language: en-US
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 devicetree@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Eric Dumazet
 <edumazet@google.com>, linux-bluetooth@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>, netdev@vger.kernel.org
References: <20240627054011.26621-1-zajec5@gmail.com>
 <171946908894.1855961.17183583790942661835.robh@kernel.org>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <171946908894.1855961.17183583790942661835.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27.06.2024 08:18, Rob Herring (Arm) wrote:> On Thu, 27 Jun 2024 07:40:11 +0200, Rafał Miłecki wrote:
 >> From: Rafał Miłecki <rafal@milecki.pl>
 >>
 >> This helps validating DTS files.
 >>
 >> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
 >> ---
 >>   .../bluetooth/mediatek,mt7622-bluetooth.yaml  | 61 +++++++++++++++++++
 >>   .../bindings/net/mediatek-bluetooth.txt       | 36 -----------
 >>   2 files changed, 61 insertions(+), 36 deletions(-)
 >>   create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.yaml
 >>
 >
 > My bot found errors running 'make dt_binding_check' on your patch:
 >
 > yamllint warnings/errors:
 >
 > dtschema/dtc warnings/errors:
 > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.example.dtb: serial@1100c000: reg: [[0, 285261824], [0, 4096]] is too long
 > 	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
 > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.example.dtb: serial@1100c000: Unevaluated properties are not allowed ('clock-names' was unexpected)
 > 	from schema $id: http://devicetree.org/schemas/serial/8250.yaml#
Oops, I really need to fix my yamllint

$ make ARCH=arm64 dt_binding_check DT_SCHEMA_FILES=net/bluetooth/mediatek,mt7622-bluetooth.yaml
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   CHKDT   Documentation/devicetree/bindings
   DTEX    Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.example.dts
   DTC_CHK Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7622-bluetooth.example.dtb
   LINT    Documentation/devicetree/bindings
invalid config: unknown option "extra-allowed" for rule "quoted-strings"
xargs: /usr/bin/yamllint: exited with status 255; aborting



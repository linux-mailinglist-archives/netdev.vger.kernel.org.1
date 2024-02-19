Return-Path: <netdev+bounces-73012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E32885A9E2
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 220A0B2611A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DB4481A7;
	Mon, 19 Feb 2024 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Z0oYaA0T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAFC45940
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363548; cv=none; b=bGRAWJmRw4RJVhGJSinFIQyj4fYJuLQZnhuuXUVodiDfhK6HVCPMxbJ9iczW7BMbCtuuDgbUSBx//vM2YMQQvJ2qKCSkYAqAOrGDjCatnJ9eoNZhZ8Bszo+qJfp77vwBhelgVMVAv1ReEe4h5S0NRFhuF6lff6iNsQWqR21IbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363548; c=relaxed/simple;
	bh=c+rfOiCkC1Yl33y4svN06aTyS1tSf8n6sobMDVXIleo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+yKJJmXjBi+SXSKGldI+exhhP/XvIWnsf5qE2jSxHBEZHKMJFnCCcslat/yCxGI2VdhmkVHhEs0vlXkqcn2vLoOqzApqu9XQ5YwmCC2Xz6ppsS6PLCO3di1CBDfpaoxsqu7mXELlGAVfKKtA41M1QtlSdKsl6Cboa/21XaUBt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Z0oYaA0T; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4126b687bceso3106485e9.3
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708363545; x=1708968345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra7B4rF1DGNxCzvmLw1JReP7tMzfxZwtt5oi6Cd76zs=;
        b=Z0oYaA0TfSuTEdNuNUx0M+oI/SFlrNxKO12RatqU9s68BdHWbCqIk4nwPiT0+aACFv
         ufQvEGURJxuKd53Du9nuagCV+oxBfrXsPvuyiLtqnYauxrhcNdeVaGej2xJhi6V3/7hR
         TxeoaQf9dnn59yPvoM78FPSty8S9S++yrosjAZn+mvEmhK0UhndPdT9LpDcB2ruPMZTW
         jGNvuOat1c1KqoXjquxBm8jN8La4qHIbAmmJAf0qyPrvzcQ26B/2E7ZMwR5yZcYE+FYx
         jT3x1dc8bmHM7TZVZOFj6sQtjx6Imw63J4vQgKt3+e74wT6Ot3+70gEVFZLlF1Wr6z8x
         fbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363545; x=1708968345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ra7B4rF1DGNxCzvmLw1JReP7tMzfxZwtt5oi6Cd76zs=;
        b=g8FYA+a16WWWmRkPQvuQeXJ2UmspvKDmgmvrzWSwJOkNc10gY9DQl9CMAO0vCusAez
         Mr++MjkIoRAVgW1eo6EanDUlMWk5LEx8x0CQXwySTHGy0qk++hg0Se/6vuXlDDeKcvDR
         MOPTnEk3qnuwOEza8242n564ooeZrv1EPYksPzcEbK41VhRKcW3JQdtLCD5DfZ9rGF/y
         YWSqIHnfbyEttsTX5uGhMr3peg6zGT3zRrk1Eku4MxBM2bm5BoCiPh/rBysL9tvEB+bZ
         VwQL+NkIslZW5JHJ/RKQUawafQ5vRgyTjss7rZbIAa2+2KedLhDBNG1BJeNeiklA781c
         sq2g==
X-Gm-Message-State: AOJu0YzLpEfuBSIFW3+DTtpIoQFglR5VbYT1OpFdWmfddExgghIIwTd/
	pr1aoWVQnUjy7Q8W9k3TV2nTUb28TKe86nFYLAo9tJYYp6BEfxj8TznACnzNWtY/p/VWQw0VVsa
	+
X-Google-Smtp-Source: AGHT+IGponmOjubaLWvN8uFEWR/aYzA/16LJm71Y58afF5BAJw4q13IEMNZDfc9G2xFHHQkZyjtyYQ==
X-Received: by 2002:a05:600c:6014:b0:412:640a:fa0c with SMTP id az20-20020a05600c601400b00412640afa0cmr3628134wmb.16.1708363545782;
        Mon, 19 Feb 2024 09:25:45 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b004126afe04f6sm1111848wms.32.2024.02.19.09.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:25:45 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	lorenzo@kernel.org,
	alessandromarcolini99@gmail.com
Subject: [patch net-next 05/13] tools: ynl: allow attr in a subset to be of a different type
Date: Mon, 19 Feb 2024 18:25:21 +0100
Message-ID: <20240219172525.71406-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219172525.71406-1-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently, when subset attribute is defined, it inherits the whole
definition of the attribute in original set. To be able to achieve
sub message decoding of the same attribute of different type, allow
spec to define different type for the same attribute.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 tools/net/ynl/lib/nlspec.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/lib/nlspec.py b/tools/net/ynl/lib/nlspec.py
index fbce52395b3b..5e48ee0fb8b4 100644
--- a/tools/net/ynl/lib/nlspec.py
+++ b/tools/net/ynl/lib/nlspec.py
@@ -217,6 +217,8 @@ class SpecAttrSet(SpecElement):
             real_set = family.attr_sets[self.subset_of]
             for elem in self.yaml['attributes']:
                 attr = real_set[elem['name']]
+                if 'type' in elem and attr.type != elem['type']:
+                    attr = self.new_attr(elem, attr.value)
                 self.attrs[attr.name] = attr
                 self.attrs_by_val[attr.value] = attr
 
-- 
2.43.2



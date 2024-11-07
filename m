Return-Path: <netdev+bounces-142885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D70E9C0A82
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3FD2833B9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C241215C57;
	Thu,  7 Nov 2024 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxlI0IiF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE9D21501F
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994942; cv=none; b=tZvET9ehypoHmZIDbuzXJdCOrRWUfSm37cUzXDQJcGxrGc8RTt4pa5OcDFMBYCwdUZGCctIGFOzjjwt1x6K5agXrq5VK+LOeRXzyLxUG4NKOEHtOW/KSNH9jJBBQOLfUV92rKQbl5+copcUUEV8SxUc0hT3g2esgp7nIX9n6ReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994942; c=relaxed/simple;
	bh=ShTuINxYOIoo/TKbWX3wmEWt4t4zV/3pVZ0rVY4h0zs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FWuObkYQJUx2xpJW94e0fIqmxLsc7gkEvNkWBHEajuRX1h7z8Hnb0ZLpAiYRP0qiZWgn0K1gI7+FG8dPcaHgwKSSYsh20UuV8WKDXSJCGwhO/zaCiIyZaCEJ/lJso9AQAXLvHXOpdwArRuC8PsnwR6E/BkCjvIAB5H9qijRzcCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxlI0IiF; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbcc2bd7fcso6888076d6.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 07:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730994940; x=1731599740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GP8fYSHagCP7r3rHGPjXvJuIYXAUEAFME8yg1XKacmE=;
        b=dxlI0IiFlrrG3DsylI4gVo/DPf/6u3oK8tGROhtiRhRG/6M3beX2ASDrFxnQRxeYDH
         FMnyBLxYo5kRjrECdW5gimyBwFrHw9l7mjiOCQIMVzMl6o8qfjA4tszKdvh4F4errwZt
         dU05Yd/4fd4z8ID46Y8WiyzV6EcGHeLOWtWx5NPIR6DSox3b3Mx3PMLh0/fDc75Qa0XY
         YUrKvwNyLLw+rf4mOY3rXx1qzrU9mkKQwTJPnqyx4rNZKYGrjYcijAI7p+Aby6LEY+b9
         e94VsHOkPYt0y3wX55YH58zKtbn40Xf1eK3r/JHoXgEWu2kSDvGBkNjWF3mD/Dirg6ie
         oMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730994940; x=1731599740;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GP8fYSHagCP7r3rHGPjXvJuIYXAUEAFME8yg1XKacmE=;
        b=r+vEq7/Z8D60oV1dr6MC253g+HMLGOz9wVRblW8Q9YEvSh4gB9vRl5oeUCnPm7mD+I
         kFgBIFkP0rO1ZpHZu4vFUY79cmYcJ3jlRlOECVeID/GEwsztDpLwTN+SCFrAfmiovV/M
         QcrxaBmZl9xKiAkDG9papz8p+9Hc6EDvHTqtk4NaqnzHUmR4B072E74zPARqnaYfBJIN
         P6nmSeo2eMiC8aU4XrcGnJznsLPJjhd4C1zdC3Ym3ed26OMG3mdjRCcqmx5AhQmj5lHr
         1LeWKs960pSf/nUZJiHP5azqsdGDpmjVRzEnM2yfUK1iI5NTTeoQzAd02u7i4ENXy0NA
         vUcg==
X-Forwarded-Encrypted: i=1; AJvYcCVDgMasfRJQxV41ylbTOPd1ExfDAvI/smWD2XEXczM0vqSoTeLd8MzTEmBGzqB24tq42wS29eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgMLwcYuYSxU1GFJwOdE0SqnbldqWWEA4aU5tJopQw9+MjUcJw
	HfyWRqiLPmkQFSus2xYzUiA3Ac0HA2NDczfuf5C4efhR7ZNIMZ0Q
X-Google-Smtp-Source: AGHT+IFRnr0T/GV8eaxA2T73krRhxy29bTVY69JEfpJEU0MiYNA1kZyZWufMxlc0b9QS9FfG1iJz3g==
X-Received: by 2002:a05:6214:3290:b0:6cd:3a49:34e8 with SMTP id 6a1803df08f44-6d39cfc2485mr5124536d6.20.1730994939778;
        Thu, 07 Nov 2024 07:55:39 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df907sm8868986d6.9.2024.11.07.07.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:55:38 -0800 (PST)
Date: Thu, 07 Nov 2024 10:55:38 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 annaemesenyiri@gmail.com, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com
Message-ID: <672ce2fa6087c_1f2676294b6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241107132231.9271-2-annaemesenyiri@gmail.com>
References: <20241107132231.9271-1-annaemesenyiri@gmail.com>
 <20241107132231.9271-2-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: Introduce sk_set_prio_allowed helper
 function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Emese Nyiri wrote:
> Simplify priority setting permissions with the `sk_set_prio_allowed`
> function, centralizing the validation logic. This change is made in
> anticipation of a second caller in a following patch.
> No functional changes.
> 
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>


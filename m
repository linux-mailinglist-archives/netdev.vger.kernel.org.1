Return-Path: <netdev+bounces-226840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545CBA57E0
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ED11C03B1E
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED051DF996;
	Sat, 27 Sep 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRSpVmIR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8C27707
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 01:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758936863; cv=none; b=WWdTmnv4jsDGPx20OOy3ZiUW2XHGjxR4xMBC/9SkySIQiDLKyYTrLqZGawi0JJXUKSC99n4b7dOSKbKdn3VQAWYjhiJiyYPmWGKc4G26r3Fg8GlBwZulHzHnabI8OiFJs66EYKbSeI+fzUXyjNzggMiVcaNmt/35Z9wsAJysnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758936863; c=relaxed/simple;
	bh=QlwK1ZPgBnWf01Sf6Wj9g/WMIBrO/hZLcZbF8cQil5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cw6QV/UEKXtJh3xRApUqKNDdY/22b5VV/VuP/iyCoWsxXlDea6iczIn+w0TYoxjm/rdIgWYf9mYy/3FiAW/aNBRys2yCHUA7HBwOdY8wkZy7rgEooNQjeilMjI1H/G+/hlpMSR9hgFbppABUUfy3GHYt9UUFOrJdQ5geMFTDhmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRSpVmIR; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4257f2b59ffso18242685ab.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 18:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758936861; x=1759541661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlwK1ZPgBnWf01Sf6Wj9g/WMIBrO/hZLcZbF8cQil5U=;
        b=mRSpVmIR79vBfNi8T2KJZZXYQfOvhBHE7P06Gq57l8RDedTjONp0Hr5DjAqcoSHmGo
         y7N6qBxH06bOSEyIjQB5c8lWn5wt8gpiCKV6zWQy3nwAK4Ff/wq2C497LiwIST7k1gI9
         RyCpc+WFXuIWfUA4pFBHh6K8aeZs4Cy6zpkLCha+puv0Gwwjil6eRJrjbXQOR3GeGur3
         0xDS+8o/Hh74aZEl01atzf6c4uzzkNV5PbgTwOFA73hfIrhy3Svkwo9sqfWRr5SxCxLH
         uyXG43S7DWBaR12D8cJEdVI6uIrARLCWGH/DRkc+1BXV2OrDBz2l4uHxncxCLeDxSmXw
         eEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758936861; x=1759541661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlwK1ZPgBnWf01Sf6Wj9g/WMIBrO/hZLcZbF8cQil5U=;
        b=wb0Gf6V4xa0Lo3bh++I2GcZ4ERKwgBZvY2VEWFPP+t+sg3i+zMTvNaTr9LvavY23zR
         522dndpHjSyX8WhaJ9ma2+lg5GuoyMlsSjWt3khYUVACLpS2J2edlT1kk6y1Tq1bvXw+
         QCi3GMEleGcT++fDNFBfYScnUO9+l5xx9WN8yE7+5zMTgSkKfSSkq/pPti0LxGEGVc7R
         da7yVmiENNr7JC7zODyr1hv0kwf1k16j+8i7gOOPC0oR3+0cgDJD60XQBEo5VkIHjEHw
         R8YEOxhg+8lLzMM57Oc93irgq/wvnXITz8eeNoHWVvO5WzXghSunvb8FbP0z0ssEYILM
         pNmA==
X-Forwarded-Encrypted: i=1; AJvYcCUgwQGkZg/ofZK/+F8PmL1DzRcwQLD7EkBnkdLqpN9zrAo0O+hs0YdloXhUuywnUYHzcPzIzY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJVarNauyOsdg71vdEXCdTcLyuryMbvz9g5gKJxe7va5pJIeC
	Rv0TP4xbv+cTjwCF2DJ+5S5wQ0b0UygwBVFCYxVgWSG98vzbqCO+dR4JJ2S1m6AB/6WG6jrhncX
	uL7nbVINNOc4LZIb3RARebtDOP8/nNDY=
X-Gm-Gg: ASbGncvVkly1wXRuX1NUxWT6HUDzBXtQ2GHLMtU5oBy9zAMCuV1kD2Dd0aNNRDo9SN3
	A3d/VscQ3D+dygsmT8Wh+GC/ciPZ0xkWukKCwcRGq2AT6pRwPuCtrmAzveCc239kcuBggCQoyS3
	qgTsRPkpH/ePBiEUKWtowEf5KSJXd/pMidxYL0rlOTprAs/YacmP5F/zIJ+JIFIYnx7tuyPIDNK
	CUrFg==
X-Google-Smtp-Source: AGHT+IF9ZWeXyum5eWiO+6BDbTsyzjpeN02JCuBU49YX2oQkgNvt14Nnt4s5DnE7tpjy04Zp/nxd+/lVpQbEqERDWSE=
X-Received: by 2002:a05:6e02:b26:b0:425:51dc:5b6c with SMTP id
 e9e14a558f8ab-425c31d86d3mr111814275ab.13.1758936861590; Fri, 26 Sep 2025
 18:34:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926151304.1897276-1-edumazet@google.com> <20250926151304.1897276-4-edumazet@google.com>
In-Reply-To: <20250926151304.1897276-4-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 27 Sep 2025 09:33:45 +0800
X-Gm-Features: AS18NWDv7qlO5Wtz9cSDIkFVEkG_JwSgvLffsoFXzTocLjK-zTGivkUy0TiOS_M
Message-ID: <CAL+tcoC-5DyVaTCS1oSOg-mAjn4=q49M681+iniWW+jjRR7PMQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: add NUMA awareness to skb_attempt_defer_free()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 11:13=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Instead of sharing sd->defer_list & sd->defer_count with
> many cpus, add one pair for each NUMA node.

Great! I think I might borrow this idea to optimize xsk in the xmit
path because previously I saw the performance impact among numa nodes.

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!


Return-Path: <netdev+bounces-68469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C60846FA2
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1271C241C9
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EAA13DB9E;
	Fri,  2 Feb 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmYmg/YO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4821386C0
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875140; cv=none; b=EmUfh0uhoFv/rfFNU5cNe93dpoG/WzVpqk585VhlhzpaAxGkDkaB8pvyZGknMHy/8NxmxMfw7aDRzV2HiFSFeek8xN5sAsds/mTI8mQcipu9Pd2HJ3mvttSWFTUeeuKF+mXLETZ/wlCS22EFeVOQf6LDKWgpKquVEkwYIJDEaJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875140; c=relaxed/simple;
	bh=hj5Jj+MSxTwJd349+cBMQWw0KG5wXUJeJj43kXE8r6g=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=HsmxvQA6ytBAa5LdUJkZCzzmOQKkjEjJaSLmcrSLSl+YxaWphXhDqd4LK032CUX6qtpB8QlUC/76vdj7p0RWGfUoNa9Je4iiIPNdtsszEeAWOWNrQB3XvWbigTFMUKxT/KLbAd1ibKilqsT+z3I3N7BaiOePrg6O/bszh3pD+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmYmg/YO; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33adec41b55so1263360f8f.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 03:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706875137; x=1707479937; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GfpoPDUqFtBdT+ToPHkb97pDEvlW2thF4z9iyaqbrUo=;
        b=RmYmg/YO/XmDDwD+vFce+eZEwuRtstBmVBnzxZiK0pWmYkmVe+VSK7mIK5YjtKYa5h
         WkqRYFQ7pj3YrgvEAo4MMrsVXcy13atyKtCO/l0XHDUX3bADRGjZ73u1CFhzV2rVBWu+
         oWDsnm3Xv77jX2noGomTPs8N+kPKTyCQwSwNTowUFLSyrkr1eZKdZT8DND83rkYd/n9d
         p4xRZCmuskErm7PAmThoDjp3HYd3sqWRhXwQ2crM8yKTb5fGHx4TyE+jtsK2/aoSExn/
         LTAfhAkcaLW/Nlbv18Ikgy6R4Df6c7+GUtWqcqf1TeAO7a1dC7zxk/Wc2xm1nUs9KIH9
         1rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875137; x=1707479937;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfpoPDUqFtBdT+ToPHkb97pDEvlW2thF4z9iyaqbrUo=;
        b=YQaVzeJtvXOd3H+YVSpo8FUkxoqrlSGLpdOgQ10ObfsuUXExBYn2SNxi4TdlQd9sJu
         Ijs9e0Ndl8zADcToqnTTGWWNyx3VobOAxfkAV5Erca7Tde4Lwzeo19Jb2IwmQ2piDv5Y
         P9/FsF1xDJJOEKunTFziYLxWhzxAGWXHBsSshD6OQBc6epj9za/TME4Tn9/PpM0PU01n
         YvERlrjBMV7NJ25fQDCoJmXloeX9RjwgfBw8LEOSFDoIy+mz3VFmuK6O9aYLBnE1f/qr
         Q+SuOE0c+ludKO9XuIb61GzQllAuLbUKDrxie8BnslfiALZfOT/YJGcroqIoHu9pSt4n
         P5KQ==
X-Gm-Message-State: AOJu0YwZDifPUBv4yM+X/RG34ptGsHijB+r2+z8h5PYCnYGs0+qPIuzr
	x/jdZF5JGUJYM3+xyxPaMxB15toAiJDMdECgq+Z3Hh7x0Y1gzdGC8P4rlHr/fzg=
X-Google-Smtp-Source: AGHT+IGyxVGz1EQa7YjLnJS2i7SPvSq+y8EFNgLIhSBxwmmSW8G3/XhAxveUjhXL7eNeVWypkKmc+w==
X-Received: by 2002:a5d:4dc5:0:b0:33a:e6ca:e222 with SMTP id f5-20020a5d4dc5000000b0033ae6cae222mr3505900wru.34.1706875136737;
        Fri, 02 Feb 2024 03:58:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFaZQKm0nsWG3DaTsksp5f4s/8FJQNhltYr3tfcBsVciYGMZeqETjL2ee8im/5bw7mkPWVDftKuPqrjLlWi5dTdqWPzx1OxJFVF66Cda1KS1CRKc4pgM9WiNDiwXnKLJ/fX78CpnruPTvpUkDRSYLlD2K73PlYi0ZWo2EUxDzGRrbvNeJ7KSB5AzivOajXYr9tlDKS7EOBDv6UrAcwy/ZBEvqy4ZgAKK8DuQcGBS1DX4LqXpgeaTPqbLdOdUuJzOs6KymPPOPlyVGC5pURJ9kKPrQz8lp2qaqy+9j+fbBbcCRySjDSYzja7R6C
Received: from imac ([2a02:8010:60a0:0:699e:106b:b80c:c3f0])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d46c9000000b0033af4848124sm1777598wrs.109.2024.02.02.03.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:58:55 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  davem@davemloft.net,
  edumazet@google.com,  pabeni@redhat.com,  sdf@google.com,
  chuck.lever@oracle.com,  lorenzo@kernel.org,  jacob.e.keller@intel.com,
  jiri@resnulli.us,  netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/3] tools: ynl: add support for encoding
 multi-attr
In-Reply-To: <2b3ec0f1-303d-4e0c-92de-5d0430470c33@gmail.com> (Alessandro
	Marcolini's message of "Fri, 2 Feb 2024 12:38:11 +0100")
Date: Fri, 02 Feb 2024 11:42:28 +0000
Message-ID: <m2frybum6z.fsf@gmail.com>
References: <cover.1706800192.git.alessandromarcolini99@gmail.com>
	<9644d866cbc6449525144fb3c679e877c427afce.1706800192.git.alessandromarcolini99@gmail.com>
	<20240201172431.2f68dacb@kernel.org>
	<2b3ec0f1-303d-4e0c-92de-5d0430470c33@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:

> On 2/2/24 02:24, Jakub Kicinski wrote:
>> I think you're trying to handle this at the wrong level. The main
>> message can also contain multi-attr, so looping inside nests won't
>> cut it.
>>
>> Early in the function check if attr.is_multi and isinstance(value,
>> list), and if so do:
>>
>> 	attr_payload = b''
>> 	for subvalue in value:
>> 		attr_payload += self._add_attr(space, name, subvalue,
>> 					       search_attrs) 
>> 	return attr_payload
>>
>> IOW all you need to do is recursively call _add_attr() with the
>> subvalues stripped. You don't have to descend into a nest.
>
> I (wrongly) supposed that multi-attr attributes were always inside a nest (that's because I've
> only experimented with the tc spec). That's also because I (mistakenly, again) thought that the
> syntax for specifying a multi-attr would be:
> "parent-attr":[{multi-attr:{values}}, {multi-attr: {values}}, ... ]
> Instead of:
> "optional-parent-attr": {"multi-attr": [{values in multi-attr}, ...]}
>
> By reading the docs [1]:
> "multi-attr (arrays)
> Boolean property signifying that the attribute may be present multiple times. Allowing an
> attribute to repeat is the recommended way of implementing arrays (no extra nesting)."
>
> I understood that the syntax should be the former (I was thinking of an array containing all the
> multi-attr attributes, and not only their values), albeit really verbose and not that readable.
>
> I've now made the changes as you suggested and tested it, it works as expected!
> I'll post a v3 soon, thanks for your review :)
>
> [1] https://docs.kernel.org/userspace-api/netlink/specs.html#multi-attr-arrays

Yes, if your input matches the ynl output then you should be good:

"sched-entry-list": {
 "entry": [
  {
   "index": 0,
   "cmd": 0,
   "gate-mask": 1,
   "interval": 500000
  },
  {
   "index": 1,
   "cmd": 0,
   "gate-mask": 1,
   "interval": 500000
  }
 ]
}


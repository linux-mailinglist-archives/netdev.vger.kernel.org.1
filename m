Return-Path: <netdev+bounces-73997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7CE85F959
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3C372861A7
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04C612EBCC;
	Thu, 22 Feb 2024 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qsVls3vY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A276214C
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607702; cv=none; b=TydHO4+XF2qUmeNjXIceWKV5hkZde3Xnp2/KMzhD7hd0IUrkhB8+1Nl4GtSgPbfZP2kLnO3Z8YH1iY1fnviuQlwLP0V2ziVlWKNVQpHJDHXIb7aJMyQc7VV0ri0S/ZcuX81stn5C4BLkhrtE3a2ntE5l1w1SH3KLjoJz2zCm9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607702; c=relaxed/simple;
	bh=gi0gnozRmuNzB3u/EMMpy0UnG9ygFbqKTFrXNYVRtk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNycqsjEjyFptcucOD8PVmWs1w0O8IFOoGpewFzt/xQHXnE6C1cBoZgzDCD2fFf2Dte2RREE2YDkFZfP/wNSbt2u6tpNFTDZEfAB3bzmX4EIo9SqP9E+b+15hJpbO2dD/Yx+ZJSaF+xlznGM+6l1y2uK1nLbtsIwn7/EVSYpXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qsVls3vY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so1807623f8f.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708607699; x=1709212499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo6KBK9AMn4uvjyM064+qKzhZg5uFvU3B4Qrcwm+BlM=;
        b=qsVls3vYMv57tpVfcgv6eacSK4EBEZ75CXVHcOWIQNs1sKAuXJIbs/dYQZOFKJuMqM
         cVFy2W7JOI1cR8FPcgKdQol9wGPJeJ6ALKnPXnP8iX80zdlZSV1eDG6vK/YD13y/2iKo
         g0hS6aVPBDETtDxsjgbQakryo0bh290zcJ7C+PXUFI31pR41plc8Gs3hl2tgoz56VBc7
         J6ds4ow+wr8l+vVzQUfmVMu0snj34qqi86TK2FKocjEMeVnLHUFFLynnj7r24dxKlIp1
         SG/EZHjkpryMA0D4oxHbkyBa/TrcpSYTDJxNR/BNnriQIaKByPdF+XAKinRiabw5giAl
         17og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708607699; x=1709212499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wo6KBK9AMn4uvjyM064+qKzhZg5uFvU3B4Qrcwm+BlM=;
        b=Cdn+91yBFzpMnUVM18NHV8Ee8iNqu2nXAxM/JQXL9CCPTycQmO587fCX+sDBCnxjgs
         NSTPo3Nm9rqZIjpsBu6qlcsMRM/Pydg0X8a9B3LudxhakvOtpPjjO4Tikvk4JdN5RRcL
         G4yLxu1f0yCtZHcQLNXfZFAYNsoL8t+lwwoicO+PRHiYuqDEol0CgV87E2a9UzJq3JMM
         BZt0VfNcfaMAKLMW6VTqKF46DgryNGm3yZ6OUwSbbJqj77p78594o5rNt0UxqwAwqTQ/
         tc387EbudHTX7xEb7QXLUAQ9ymKgwYYShSWnBQoml+Cskr79Vw/pFCx2d/g24EXVO4mi
         zT2g==
X-Gm-Message-State: AOJu0YyTsG8Lb/iH0AYtCVL3ojR4nlJ9a+PpM9ybB6qto0UFEfAgmVJE
	zf4YsgAuwr7xe/JYmBC97REasSbFtIW+QTjoJTAR15KyvnwFQurhJsEAgPD3i8o=
X-Google-Smtp-Source: AGHT+IFnS4d09jD/qGHrGPrWD17ZCu9wTsrWHTSag1MKqk4Skur9NPeK+9B+7W3W/w/w6fcracqrVg==
X-Received: by 2002:adf:f492:0:b0:33d:3f21:b9f3 with SMTP id l18-20020adff492000000b0033d3f21b9f3mr8317038wro.64.1708607698763;
        Thu, 22 Feb 2024 05:14:58 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bx14-20020a5d5b0e000000b0033d6bd4eab9sm9464935wrb.1.2024.02.22.05.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:14:58 -0800 (PST)
Date: Thu, 22 Feb 2024 14:14:54 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com, donald.hunter@gmail.com,
	sdf@google.com, lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next v2 3/3] tools: ynl: allow user to pass enum
 string instead of scalar value
Message-ID: <ZddIzlOHxYCrQibb@nanopsycho>
References: <20240221155415.158174-1-jiri@resnulli.us>
 <20240221155415.158174-4-jiri@resnulli.us>
 <20240221104936.7c836f83@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221104936.7c836f83@kernel.org>

Wed, Feb 21, 2024 at 07:49:36PM CET, kuba@kernel.org wrote:
>On Wed, 21 Feb 2024 16:54:15 +0100 Jiri Pirko wrote:
>> +    def _encode_enum(self, attr_spec, value):
>> +        try:
>> +            return int(value)
>> +        except (ValueError, TypeError) as e:
>> +            if 'enum' not in attr_spec:
>> +                raise e
>> +        enum = self.consts[attr_spec['enum']]
>> +        if enum.type == 'flags' or attr_spec.get('enum-as-flags', False):
>> +            scalar = 0
>> +            if isinstance(value, str):
>> +                value = [value]
>> +            for single_value in value:
>> +                scalar += enum.entries[single_value].user_value(as_flags = True)
>> +            return scalar
>> +        else:
>> +            return enum.entries[value].user_value()
>
>That's not symmetric with _decode_enum(), I said:
>
>                     vvvvvvvvvvvvvvvvvvvvvv
>  It'd be cleaner to make it more symmetric with _decode_enum(), and
>  call it _encode_enum().
>
>How about you go back to your _get_scalar name and only factor out the
>parts which encode the enum to be a _encode_enum() ?

Okay.


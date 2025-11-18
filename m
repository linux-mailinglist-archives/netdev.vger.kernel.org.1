Return-Path: <netdev+bounces-239448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B5CC68808
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 93E972A78F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F693148D6;
	Tue, 18 Nov 2025 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL22y+dI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041272EA743
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457729; cv=none; b=ux/m6axAJF7YgX+7rHW5irdH0D8r+nX9UrQz0kKRHuVrCURZV6+C+w6QRiL35vzGoI/LmH+vIU9Zf/xbJvykR/yjG5dxdY6xwExObPH/dL4uxvvYJXdPK00RVw4nBoqvgdlmC272czPpaTzfDQUOkZPG/0VksaGH+e7dCD3EnVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457729; c=relaxed/simple;
	bh=BvOFQAdy9zjJKDHz1JA0HgglsdARQQ0adRPw9YpAmhM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=EtPM/PLOcESQFGU36lRTjlL5aKeFSD9+ni7K6/T7iqSSHPF9p5GoQeF0SLrR40h5PTX0PHWggTyl7AyeffPWuF5ClWf3EfQ21eZVJ4PVdWfTUP/k8HZHNuRXvJmFuyp2nje+CU7yZmM0QCalFdUtLTnlb15yLxzmkZmEENvkyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YL22y+dI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4775ae77516so57817205e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 01:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763457725; x=1764062525; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9PnZqYfIzULXWhxWLD9KbztWyXV9i31fSKXw0TFJSM=;
        b=YL22y+dInl7eOtPzbxUXKZe7AD0/7yMfLv1enhSandlAu9DS+52Rcf0I+gph3X3969
         btDi23gZR7eaVscZXv5GX1BVQjR7qRlXJZ2scK6R5J1cod85upGSlLsUBJEnQ5SZ5QMk
         vqG960LUly0N/wapCcRxmmZAHUr+bqi5oC/vS6mP6XmQUrqmzfZv+UT3OzBSdC9kN2Y3
         YV0orcGlE+8+RffYrGayetvqgn6wGvi6ft1OwJsnr6nrxPEx19S3m5OhTVqVBbdMLBwI
         Blt450VZpRYUKOozoP3/ASNaA+zi/7TjPuhG3F13HBH2k47NrVKxsBZnz8ecAZtzeQJN
         Y1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763457725; x=1764062525;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n9PnZqYfIzULXWhxWLD9KbztWyXV9i31fSKXw0TFJSM=;
        b=lqc01RUkEeikNjrWqralHzRomvOTalK2TJwyikPI8dR0B6M5qa3ocLhmJqLy96E+rc
         Rkm4xFpsZ5bziFH54GlVOyx/4jAFFsTsyCyNTVr8up732xVi0XkBq1nIDCH4YCxu52vi
         PJdu7K7em2M1nzhTHfyYGs2GP1jIRKI4gIxBNyZ+hDDKFEjlZ74KS/WLmfNLrSH80Rx4
         Dvri/2Q6+Uos09OCe7gegS4L/nI+dAijx7lMNSfS+0WZXAjwBKUd3XpNiN0oq7VpgK7b
         xrRIsSIeuHFFkIu2HEjTXLvdIesasinqvypexjcExhqZIPfUKHZQz56W+TLv+qfkm71f
         3TLw==
X-Forwarded-Encrypted: i=1; AJvYcCVXtwQ0m6/I/ZQDY/zXxq7oTeMcU9rggUcSDwDMJG2SntkMuyMdCClv16nOxcQODmX5kzH65Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKriWhihVyNzsZ1coCKcR8n1nS1YygsNKiLPWMXZ8dgFDBRw3h
	eNSNwm/MiCb7yKi/GbOJkEiuE67JByPONN8gdL3CtnK0ugfg6qKAgNEz
X-Gm-Gg: ASbGncuLulSowuDkRnkiAVlqNW5q5bWnoVSZQU14F+8LezVabXqbTNkqXgduI9GY3g9
	JZzN9e/U1mJ9EP4HaaHFVWTgeVpINzgslGkIYBU29vbciNZ3KgzttYxMrS9ZnaMf1L+0lX+Ylhs
	rcCWy5jUechgXRVZr/Ocjnk9Le4PCS2MCK2G2JfI0AOhlxpJTQpgZIwXrK5oBpLlPogcgO5ZMi0
	Tqnky9ATxTW82geQ/GjFeputyzKo9ULn9cRhfojbtQS4E+LsNqlJaoKeYHw5FlFCNzJPalr6OkY
	tGyipCox6EtWvpssB92ALZ99vv4TKds25zvQmBk9BGLFDwjBC/WHFOqFsdzWZEqskmn7oFFsH6w
	vuqPvl27D9RjhWsrz420hI/TRdK61bh/zzLqGB5Pw6ILsEgBo7jjXaTQ6DD/EDBXTF36TpB42XE
	0PLm4TxQk2H2Yvhawxx+6m2m3kfMa4szLSwHyaoROfn3hr
X-Google-Smtp-Source: AGHT+IGSr/3N2cWhsJqtnk0wg9x/yA/uNhYB0j+Mk1qBcmIOENJcOu7NXZJlQH8vYKujOTqblYlcPw==
X-Received: by 2002:a05:600c:45d4:b0:477:7c45:87b2 with SMTP id 5b1f17b1804b1-4778fe5dde3mr190114145e9.16.1763457724945;
        Tue, 18 Nov 2025 01:22:04 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:295b:6b4b:e3b5:a967])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e953e3sm346458935e9.14.2025.11.18.01.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:22:04 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gal Pressman <gal@nvidia.com>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  <netdev@vger.kernel.org>,  Simon
 Horman <horms@kernel.org>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  <bpf@vger.kernel.org>,  Nimrod Oren
 <noren@nvidia.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl: cli: Add --list-attrs option
 to show operation attributes
In-Reply-To: <20251117173503.3774c532@kernel.org>
Date: Tue, 18 Nov 2025 09:20:50 +0000
Message-ID: <m2y0o3lmrx.fsf@gmail.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-2-gal@nvidia.com>
	<20251117173503.3774c532@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Sun, 16 Nov 2025 21:28:43 +0200 Gal Pressman wrote:
>>
>> +    def print_attr_list(attr_names, attr_set):
>
> It nesting functions inside main() a common pattern for Python?
> Having a function declared in the middle of another function,
> does not seem optimal to me, but for some reason Claude loves
> to do that.

It's common for closure-like things and for scoping. Reviewing this
again, these add a lot of noise to main() and would be better separated
out.

To be fair, I started it with `def output(msg)` but I'd argue it is a
closure-like scoped helper thing :-)

>> +        """Print a list of attributes with their types and documentation."""
>> +        for attr_name in attr_names:
>> +            if attr_name in attr_set.attrs:
>> +                attr = attr_set.attrs[attr_name]
>> +                attr_info = f'  - {attr_name}: {attr.type}'
>> +                if 'enum' in attr.yaml:
>> +                    attr_info += f" (enum: {attr.yaml['enum']})"
>> +                if attr.yaml.get('doc'):
>> +                    doc_text = textwrap.indent(attr.yaml['doc'], '    ')
>> +                    attr_info += f"\n{doc_text}"
>> +                print(attr_info)
>> +            else:
>> +                print(f'  - {attr_name}')
>> +


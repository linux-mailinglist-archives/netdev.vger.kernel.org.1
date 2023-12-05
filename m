Return-Path: <netdev+bounces-53895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DD48051B9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 12:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA71A1C20B37
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 11:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5619255771;
	Tue,  5 Dec 2023 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="p68CR8U0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC3211F
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 03:11:49 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c1cd8d239so6302110a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 03:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701774708; x=1702379508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzDinn5c/Y7C7N2ng6YfBd5P0SV274JBkNtLEE70va8=;
        b=p68CR8U09nT4Dq4fHndlGBx6fbI43INj4a4OiIFWPwvq9lrt+fEgV8yZveS2lTQcdu
         n3PAAZh5xqm/naHKeLyeeGMtoP0O45OFnE8+E0U2v3u3Z1zp56+7+t8Iz03FPF1Ud5Xe
         gXYLJvlRmX1fj9iOMLYiB5KTA5KyOyOOlBVh5+ESDWlBKwKDWNttEWWOinlCeArtoBIa
         Bg14DQ3BBwRzcLQ1ish0RTy+ZNUtWrw9W1EOLdE11Kte0oR4/epgsrlhTg4fPqYH5EIi
         JlkAMgxPYsVDr+UrI+GJt+XmgM7ew280z5SvEvT2/kiP/8A+d5eteRvG43s5PPyfS69L
         YYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701774708; x=1702379508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzDinn5c/Y7C7N2ng6YfBd5P0SV274JBkNtLEE70va8=;
        b=YJxCCLc+9kyhyxMqreJljVbk5T4l1Fe8zxAxvWW1D/yOcDMpy00EsXODXoign8mYND
         dspol0IthnQhjnfy/CdgBsSp3MjKwRQ5sdYFInWdNvq+GWABBQG5eUSQI1eN+XzTdGhu
         d//dU/LFBeA5R9pUeiYg5G3m/8xbQB5CwONE+HTKvzGYuYVXWnKMAAIYU8b9KggkTBGN
         K4B8H5tKvbNb/8Groyeay8h1sJz4nSh/07RJgajPJ5Hh5IAO011rY05MqZw2XAfj5WWB
         ZzQ2NvTUvaiupsiUCahNt4caXUzq99AXuQtjuRi2+YEX+oxMgvS1eUk7pYhJm5J06WwH
         FaEA==
X-Gm-Message-State: AOJu0Yxh+CZqq9bBN17INLFP9FS52mwZBHJYr1tKAsnsC/YTBwvumZhV
	fo539taoiY9lW24bPk0dV3jCLjZK3y8SXYncL2w=
X-Google-Smtp-Source: AGHT+IFkEW8iKF/q7VdB/NTnsVGQX0dWvcPX+36Qw+i/kbTMdXMq8sEo220DZ3j2ySZB50rCjogviQ==
X-Received: by 2002:a50:a412:0:b0:54c:761d:988b with SMTP id u18-20020a50a412000000b0054c761d988bmr1396587edb.67.1701774707911;
        Tue, 05 Dec 2023 03:11:47 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e21-20020a056402089500b0054b50b024b1sm928743edy.89.2023.12.05.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:11:47 -0800 (PST)
Date: Tue, 5 Dec 2023 12:11:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ip: require RTM_NEWLINK
Message-ID: <ZW8Fce18JOKSJW0F@nanopsycho>
References: <20231203182929.9559-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203182929.9559-1-stephen@networkplumber.org>

Sun, Dec 03, 2023 at 07:29:14PM CET, stephen@networkplumber.org wrote:
>The kernel support for creating network devices was added back
>in 2007 and iproute2 has been carrying backward compatability
>support since then. After 16 years, it is enough time to
>drop the code.
>
>Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!


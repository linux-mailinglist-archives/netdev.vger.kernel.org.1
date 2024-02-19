Return-Path: <netdev+bounces-72932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 174C285A392
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 13:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC0E280FB1
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFAC2E410;
	Mon, 19 Feb 2024 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="b35UGPjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670A2E82E
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346264; cv=none; b=EJWMcN1fAweqLgizGfdyM5x8LR3Cviw/pfnc1cInfm1CX2M9X0XjJbBRLzl2rli6OKoKlN9LQaDMmsrJBIf9FQZAECsn3qJnGUIDa8cgjd8IdbPBiylGh948KkzTjEl9KDo2htJwJeOGFPTx7wX8pUS1FN+T084n5MqJ1cJleBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346264; c=relaxed/simple;
	bh=WGnAVVXUOiSMlK6G4xvU719QnwSrb5vZtW5+1BVcc6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvtYZUSWvi8qIe869piPF3eSOALxVxXTWH1kOLYy2MWyooMvNnFQbYAgkTvZlMdjGVbrapQvdgz8pNtKpp2UQNUXYc33qi853dgf4qbBpMGujbgdU+ui+sDYwud+w/UJIUAIPLIMf9bVHgw6svdb2CmdsauMcoQZYKuXW5JC0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=b35UGPjh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4126ada76bcso1390245e9.1
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 04:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708346260; x=1708951060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JPxHq3D4TTHsU6KrmKx/OnWiAztnrNLyJq4950Jts04=;
        b=b35UGPjhJ5CbIgQrChxf7r3IGbVSzEG2KSb5hKBD7+Uab3aDjcvF8eFn7hngNPkmkM
         rmj+fIoPZbSjgHCcxIevmyYBw6cUVE5SWWlUId6mEJBeLwk8PYIEHgHm+CfBwHGjQaI4
         WbW4uCcbNaJfiKFi4sic9HulLdfuFro0Vjqxs5cym2R4Xi//Ys946HNw9f+3UDXZGmf1
         A6kyHGJ+NJNrl7MVOYUZ8f9MU31sTU6kM6OSFXpJ7qwlaJQ4/hVOSgOLIhvPCrJ6q2HO
         P9zWzqd9lx2mMkmYHh/g9bt7WU0JWnKtjmSP7iEonZqHJUuH0Pal1CSWZOyhJ3puJD83
         RCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346260; x=1708951060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPxHq3D4TTHsU6KrmKx/OnWiAztnrNLyJq4950Jts04=;
        b=VpTfv3VDlGb1MmFfiX8wUE3VseU7QXRih+4W9lyZGAZtbNIFKCV5rY9paKGOpLK9k/
         2ynJgF18gVUq2poD+PdZzRDga6oB84HinV3VShbqYN0xRum08FiXKFkX5lWn/gvgvJJf
         zCQqGlvalfYaz0kNRV/eNEipPqYTbBseBlvOH1ObEb5vdkL3d2owSjNY8F+5VtIBORjM
         sRI85bQp/Y4QelhIHVlO9EyTOi9lmKtLTCy0+UA/M4tze5oxVmbs+wxdwXkUw1qgEyQI
         5L/Aw/HDpcl2qp1OvFPus+UWjSvYQq4wN8NG3ngmEt+KD8BrneHn4JCCb/DJQeSp1heb
         TkJw==
X-Forwarded-Encrypted: i=1; AJvYcCUiVQvdL7OqezY3M/FBRRlvhkZ67Ue9SoT3bRNTTS/pL3YbiBimmvizoPqBNSQIBXJdt9m3IiiQIS6t0xAy4B9Mgie04AX9
X-Gm-Message-State: AOJu0YykSXo996NMSt2UBkdMp0gM/EyjxjXHELxxPomBHoHOXeJOMIAz
	ufUKXico3I5jRm+ZqtUj8BxEzzfsnGZItHWnw3wt/J40gKOrwoaTi6WO1QrsOks=
X-Google-Smtp-Source: AGHT+IEkfABZ7VVSTA8/OZaotC9kUyyIJ6Xbm8TXRcDqcL2B+C4FTtx2U8tHvdg6GWBayk3uMUKsDw==
X-Received: by 2002:a05:600c:448a:b0:411:e27d:5250 with SMTP id e10-20020a05600c448a00b00411e27d5250mr9757299wmo.37.1708346259739;
        Mon, 19 Feb 2024 04:37:39 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c350500b004124219a8c9sm10967222wmq.32.2024.02.19.04.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:37:39 -0800 (PST)
Date: Mon, 19 Feb 2024 13:37:36 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, przemyslaw.kitszel@intel.com,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Add
 tx_scheduling_layers devlink param
Message-ID: <ZdNLkJm2qr1kZCis@nanopsycho>
References: <20240219100555.7220-1-mateusz.polchlopek@intel.com>
 <20240219100555.7220-5-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219100555.7220-5-mateusz.polchlopek@intel.com>

Mon, Feb 19, 2024 at 11:05:57AM CET, mateusz.polchlopek@intel.com wrote:
>From: Lukasz Czapnik <lukasz.czapnik@intel.com>
>
>It was observed that Tx performance was inconsistent across all queues
>and/or VSIs and that it was directly connected to existing 9-layer
>topology of the Tx scheduler.
>
>Introduce new private devlink param - tx_scheduling_layers. This parameter
>gives user flexibility to choose the 5-layer transmit scheduler topology
>which helps to smooth out the transmit performance.
>
>Allowed parameter values are 5 and 9.
>
>Example usage:
>
>Show:
>devlink dev param show pci/0000:4b:00.0 name tx_scheduling_layers
>pci/0000:4b:00.0:
>  name tx_scheduling_layers type driver-specific
>    values:
>      cmode permanent value 9
>
>Set:
>devlink dev param set pci/0000:4b:00.0 name tx_scheduling_layers value 5
>cmode permanent

This is kind of proprietary param similar to number of which were shot
down for mlx5 in past. Jakub?

Also, given this is apparently nvconfig configuration, there could be
probably more suitable to use some provisioning tool. This is related to
the mlx5 misc driver.

Until be figure out the plan, this has my nack:

NAcked-by: Jiri Pirko <jiri@nvidia.com>


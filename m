Return-Path: <netdev+bounces-115325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831CF945D6E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 13:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04B7E1F221FF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D171DF66A;
	Fri,  2 Aug 2024 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="z1oivRUT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7561DB44E
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599592; cv=none; b=AH5Y9IfcnrqmVaCKSYZmMngPAoiOm9P7w0iHLMPfElQvYVbFKILvQo+GWdgX74kDajttUJTrG1AKyq7o48w0bk4MsHt8SqNz9fX2OWEILXIoqafT2YcgCCgJCeqFLma/uYXjtj0J0Pw6JjVFM0TAz6o5lJGYkX4p84qaCUEnpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599592; c=relaxed/simple;
	bh=r+tCe35hVqKNGZdmMgNljK7bREldDRRk66QpzEcYthA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuXYLUr7cskkZ4fS0J4CSydOwMkwF+P6O5lEnezfXBnz9DXaISkXG/z/FDzAD6ZAe65ZkiD75fGpwCZvKHNeMZkR2bu9elLM+rO4oWOEUs81PF+otQNDL80rQEbuu0qWd/TF34CCqAhrDJxC0GNT9LlrtF/qHIwkXT99CrmpOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=z1oivRUT; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso48228545e9.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 04:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722599588; x=1723204388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aXABobhusUGUi+agQkYCYW+HCXbc4FgAhOpP23VWgf4=;
        b=z1oivRUT5pnPZZ8U2AKZdeoYuHFsHld2IrniOD2hWk+tjhwShWB3+qJPHBgxqDGgtN
         HTYaXVXk8MeoQOlUYDP6BB1bbaXnq2+7Ee4HBH6G01rE6yKS4g4pE6WTsYyGD8XGAsMS
         Doahu1Poktjypg4zZunvfmI6jGBVd7VjCcL6L0KGi1PO7oQ42BSFWDsxxQ+4Gq2e9/cC
         hTgpe7VszTAtu6Znv2yucTH+Db9aIEg+JviQitJX6fZbj43BIGQsx7Sgle+E47L7Fc4a
         za5vSKkFWyl+zVSUFfxJLPZ78102OQMS9n1DZcDUoV6ZM4q6/uo0VTyN0e4HYYoXuxNQ
         Dz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722599588; x=1723204388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXABobhusUGUi+agQkYCYW+HCXbc4FgAhOpP23VWgf4=;
        b=E3Fo1sCyRwJhPLj0Jq65b3qXVnUNkQwPG3pR8Cnb3PiNOAOf+W20RG2KV/yKZx2Btg
         U94LSbiocaAOqWemNGhdpkQhhyjPrwKx8CzI2D4gTk7XhLvdoaSWxw3cGfHAfkpZRDpq
         pP8Kgen91OOEhKnrVHnP8tRJ6M/i0lL75qT+8gQVi4DOf66XrIPxRY85lawwlAuFA9a6
         43s/IL/IAoyV7ReyDabhHL2siN1McDSyIzV7AcBZuAkxiAks5ucDPqQUCn5JbmHRscKa
         xv5XZiRw+l9zs72AEPrA0UbbgSZHwq+9xVKccXwIj7LjT8h3fTEE55b6Fo3fSfolxkQ9
         lD1Q==
X-Gm-Message-State: AOJu0YzXxKgMUzfuUt1hd//mb4JnYDhBh3FXTD14g4OPjra4VOUl/bgi
	HhoOHn60dN41S15QLNyLBLSeAjX3s0/TOqD3dqEuPyXPYd5V/osP1qgPXaeMzKk=
X-Google-Smtp-Source: AGHT+IHBzzb1+2B6JaRrcI0D/Ht4DsDG0NyNv7ykczF9HQqQZjdXMLNW2j1HTC8b9oL/7chh5yakcA==
X-Received: by 2002:a05:600c:1987:b0:426:641f:25e2 with SMTP id 5b1f17b1804b1-428e6b7e80bmr19534495e9.25.1722599587942;
        Fri, 02 Aug 2024 04:53:07 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb63f21sm90725855e9.29.2024.08.02.04.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 04:53:07 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:53:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <ZqzIoZaGVb3jIW43@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>

Tue, Jul 30, 2024 at 10:39:46PM CEST, pabeni@redhat.com wrote:

[...]


>+
>+/**
>+ * struct net_shaper_info - represents a shaping node on the NIC H/W
>+ * zeroed field are considered not set.
>+ * @handle: Unique identifier for the shaper, see @net_shaper_make_handle
>+ * @parent: Unique identifier for the shaper parent, usually implied. Only
>+ *   NET_SHAPER_SCOPE_QUEUE, NET_SHAPER_SCOPE_NETDEV and NET_SHAPER_SCOPE_DETACHED
>+ *   can have the parent handle explicitly set, placing such shaper under
>+ *   the specified parent.
>+ * @metric: Specify if the bw limits refers to PPS or BPS
>+ * @bw_min: Minimum guaranteed rate for this shaper
>+ * @bw_max: Maximum peak bw allowed for this shaper

"rate" to be consitent with the text one line above?


>+ * @burst: Maximum burst for the peek rate of this shaper
>+ * @priority: Scheduling priority for this shaper
>+ * @weight: Scheduling weight for this shaper
>+ * @children: Number of nested shapers, accounted only for DETACHED scope

"children" are "inputs"? Or "nested shapers". I'm lost in the
terminology, again.


>+ */
>+struct net_shaper_info {
>+	u32 handle;

I wonder if the handle should be part of this structure. The structure
describes the shaper attributes. The handle is identification. In the
ops below, you sometimes pass the handle as a part of net_shaper_info
structure (group, set), yet for delete op you pass handle directly.
Wouldn't it be nicer to pass the same handle attr every time so it is
clear what it is?


>+	u32 parent;
>+	enum net_shaper_metric metric;
>+	u64 bw_min;
>+	u64 bw_max;
>+	u64 burst;
>+	u32 priority;
>+	u32 weight;
>+	u32 children;
>+};
>+
>+/**
>+ * define NET_SHAPER_SCOPE_VF - Shaper scope
>+ *
>+ * This shaper scope is not exposed to user-space; the shaper is attached to
>+ * the given virtual function.
>+ */
>+#define NET_SHAPER_SCOPE_VF __NET_SHAPER_SCOPE_MAX

This is unused, why do you introduce it here?


>+
>+/**
>+ * struct net_shaper_ops - Operations on device H/W shapers
>+ *
>+ * The initial shaping configuration ad device initialization is empty/

s/as/and ?


>+ * a no-op/does not constraint the b/w in any way.

"bw","b/w","rate". Better to be consistent, I suppose.


>+ * The network core keeps track of the applied user-configuration in
>+ * per device storage.

"per device storage" reads weird. "net_device structure"? IDK.


>+ *
>+ * Each shaper is uniquely identified within the device with an 'handle',
>+ * dependent on the shaper scope and other data, see @shaper_make_handle()

The name of the function is net_shaper_make_handle(). You refer to
"other data". What is that? I see no such thing in the code.


>+ */
>+struct net_shaper_ops {
>+	/**
>+	 * @group: create the specified shapers group
>+	 *
>+	 * Nest the specified @inputs shapers under the given @output shaper
>+	 * on the network device @dev. The @input shaper array size is specified
>+	 * by @nr_input.
>+	 * Create either the @inputs and the @output shaper as needed,
>+	 * otherwise move them as needed.

I don't understand the sentense. So this creates either passed inputs
and output shaper, or if they already exist, it links them together in
desired way? Or what do you mean by "move"?


>+                                        Can't create @inputs shapers with
>+	 * NET_SHAPER_SCOPE_DETACHED scope, a separate @group call with such
>+	 * shaper as @output is needed.

I don't understand meaning of the sentence. The caller should make sure
that NET_SHAPER_SCOPE_DETACHED is not in the inputs, so drivers do not
have to sanitize it one by one. Then this sentence is not needed here,
is it?


>+	 *
>+	 * Returns 0 on group successfully created, otherwise an negative
>+	 * error value and set @extack to describe the failure's reason.
>+	 */
>+	int (*group)(struct net_device *dev, int nr_input,

Perhaps better name would be "nr_inputs" or "inputs_count"?


>+		     const struct net_shaper_info *inputs,
>+		     const struct net_shaper_info *output,
>+		     struct netlink_ext_ack *extack);
>+
>+	/**
>+	 * @set: Updates the specified shaper
>+	 *
>+	 * Updates or creates the specified @shaper on the given device
>+	 * @dev. Can't create NET_SHAPER_SCOPE_DETACHED shapers, use @group
>+	 * instead.

Again, similar to the NET_SHAPER_SCOPE_DETACHED comment above, the
caller should sanitize this. Why is this needed here then?


>+	 *
>+	 * Returns 0 on group successfully created, otherwise an negative

Which group? C&P mistake I suppose?



>+	 * error value and set @extack to describe the failure's reason.
>+	 */
>+	int (*set)(struct net_device *dev,
>+		   const struct net_shaper_info *shaper,
>+		   struct netlink_ext_ack *extack);
>+
>+	/**
>+	 * @delete: Removes the specified shaper from the NIC
>+	 *
>+	 * Removes the shaper configuration as identified by the given @handle
>+	 * on the specified device @dev, restoring the default behavior.
>+	 *
>+	 * Returns 0 on group successfully created, otherwise an negative

Which group? C&P mistake I suppose?


>+	 * error value and set @extack to describe the failure's reason.
>+	 */
>+	int (*delete)(struct net_device *dev, u32 handle,
>+		      struct netlink_ext_ack *extack);
>+};
>+
>+#define NET_SHAPER_SCOPE_SHIFT	26
>+#define NET_SHAPER_ID_MASK	GENMASK(NET_SHAPER_SCOPE_SHIFT - 1, 0)
>+#define NET_SHAPER_SCOPE_MASK	GENMASK(31, NET_SHAPER_SCOPE_SHIFT)
>+
>+#define NET_SHAPER_ID_UNSPEC NET_SHAPER_ID_MASK
>+
>+/**
>+ * net_shaper_make_handle - creates an unique shaper identifier
>+ * @scope: the shaper scope
>+ * @id: the shaper id number
>+ *
>+ * Return: an unique identifier for the shaper
>+ *
>+ * Combines the specified arguments to create an unique identifier for
>+ * the shaper. The @id argument semantic depends on the
>+ * specified scope.
>+ * For @NET_SHAPER_SCOPE_QUEUE_GROUP, @id is the queue group id
>+ * For @NET_SHAPER_SCOPE_QUEUE, @id is the queue number.
>+ * For @NET_SHAPER_SCOPE_VF, @id is virtual function number.
>+ */
>+static inline u32 net_shaper_make_handle(enum net_shaper_scope scope,

Why is this in the header? It is used only in shaper.c. Should be
private to it.


>+					 int id)
>+{
>+	return FIELD_PREP(NET_SHAPER_SCOPE_MASK, scope) |
>+		FIELD_PREP(NET_SHAPER_ID_MASK, id);
>+}
>+
>+/**
>+ * net_shaper_handle_scope - extract the scope from the given handle
>+ * @handle: the shaper handle
>+ *
>+ * Return: the corresponding scope
>+ */
>+static inline enum net_shaper_scope net_shaper_handle_scope(u32 handle)
>+{
>+	return FIELD_GET(NET_SHAPER_SCOPE_MASK, handle);
>+}
>+
>+/**
>+ * net_shaper_handle_id - extract the id number from the given handle
>+ * @handle: the shaper handle
>+ *
>+ * Return: the corresponding id number
>+ */
>+static inline int net_shaper_handle_id(u32 handle)

I undertand that you use the handle for uapi and xaarray index purposes
as consolidated u32. But, for the driver ops, would it be better to pass
scope and id trough the ops to drivers? Driver then don't need to call
these helpers and they can all stay private to shaper.c


>+{
>+	return FIELD_GET(NET_SHAPER_ID_MASK, handle);
>+}
>+
>+#endif
>+

[...]


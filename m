Return-Path: <netdev+bounces-267172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKY2AoH1smmLRAAAu9opvQ
	(envelope-from <netdev+bounces-267172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:18:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE3F2767EB
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B864302642C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED5C3F99DB;
	Thu, 12 Mar 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxDOePfv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1880373BFA
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335924; cv=none; b=Q0oS0KfohuHvMFS1HEX15L23o1vGDHatjFIKydSVtKfPqGRBUN0iSE0R98h5F6cRdy8Y4ctxbvop+Tm8cz25FyNhlQBZh/Shus9KhcU3TpdYAjADw9AXFOIilp3cBYcEQgnswXL6Z0LKXJv5yKv0jBOIWOqTqtPJgZZlS2Ky9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335924; c=relaxed/simple;
	bh=ndH024th091qZmX584oGTXtZizf4LqaUONy9B6SBLtU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=nUVlgAs4WwUdk5nAU2xwrh5Fffi/+hGGPMK0pqggVlrprFwaLDbLiJZKV8liwtwl4TANtyAtHk60gBZoSnbrs8lyANfXESlcc575iiKnGf7V5NvMPzdKld8uCnsCf25dsHvdzbAFKsOp7mmXaxXJjMEtPxCdIprvqGXFaHwaPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxDOePfv; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso1724755a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 10:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773335919; x=1773940719; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n89BKkvKnK9oUy461M8tXOh1uJvswCD9P31wFhdVgjc=;
        b=BxDOePfv+/V2+zQHO0Ktsxmo3AcJ34HHIBTKRBVh1EJusYTqnBhu2KP0zszqJjBxLE
         7LrvypGM60L/UK61Di+xQ+oS1ciHtsHQSGzvof0oHYudlMHXSuExZJ4ueEVhjNv6VmUH
         BBOdsnUUeAXyT4zEVaVmAkW0/C6jLz3+N+tj9bNbAleecDHjWmFEzWPdwDTCWZvnaOcp
         4o2fcsUsprmUvYHUq1AmC/eWhC2UvsKl/wLCwJNBbMXHraGrYtr30NJMUmO8XVRldoZ0
         jAeg2kIe6IUfJb+MjdTrJIZ8TMpBlj3O1N78O3q5gY9aNEg7UCWiMxxzWZ42cxjZHEPi
         UU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335919; x=1773940719;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n89BKkvKnK9oUy461M8tXOh1uJvswCD9P31wFhdVgjc=;
        b=h/upSzv8FjATu7bWJoHXVtGjnTBE6P/tvYJrlWX/+V9YLAte5ZziDqKcgYdF5HhpEE
         4JDRe3Up7zoDUJ12yxOtG4bQzuRw4+ETSzS90OowjfEhcUMPNLqFI3a1hYTqud/G4pHQ
         /+928ij1UYx6YfqkXxbh0v8LMWiO075blbgRxUMWOhRTakw0TCD/mDdwSmJEGKZ96B/S
         DdgzGVhzIUza1xzMN+qlM6VdZtcPLuCoh5srxPSsV3FKz2sqyPuGpUwcVvks2pD/1hYg
         s6Wqz+iZ9txr1r+dg5+6HuVJN2ApFqKs43KlNffcjGjwRbCoPbMitJVjKzylosRPU3ZF
         DOxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPU6TDIoRA2C0UV0ke8b9Cy0ycb7AN2zjCNY9978uyotBw6KbC3CL0p67NF0pp6SJ9QLrEQVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+oKpu+ABWSlgow6M52Txfj6zPFdCT3Fvydn81VLlJzEf0ECT0
	pbta+EcX2dgmaUSGLOCtz+ZbYOmlHrdEJZnDE+HaFGgQW7an+HhHD6Ep
X-Gm-Gg: ATEYQzxUZnvNptQCQF/naczYG1t2P9jedf85oeWPaXQAUB16u2ctA9bg9b1ciEAaA0Z
	zCxEO/YtDITXuxRoXVQUZ/i1idtnoGZnSOvEDEM+Mp7Y25rsvZIkRIP/uI8YB02xzIInb3ugebp
	zKVMMfD49h8G/A4TyHmvQSUFxTGO6lvbcJ/E8Ytk0xv4DCVD0Lx8ywQ7WvOljAbLDz2Y9fGFEAj
	pcKc0HkVC7ksS92xgGDHq7kRJ+7N8MbBIpjugOxAzrtK8DHA1OzO7k2xp2qP9lLgz2JFB16dpBB
	tj9L99hNjQa9/VK47msYlCzp/aKMYwPPFg4m4gW2Vr8fdiWsTJ3fzJLw+u2vQX8j/SoLiBufHJ+
	9x+gMXZMU8c73a6dDA2XkHQ7Uh+6KQgqEqAZW9VicjLKzjHFgmZasWqrdBKd2qqjXRMyKzjNYbm
	gqbm9jJMJFgh++6UQO70Frz8rN6g==
X-Received: by 2002:a05:6402:1d4b:b0:660:f609:2eca with SMTP id 4fb4d7f45d1cf-663babff58dmr127651a12.18.1773335918689;
        Thu, 12 Mar 2026 10:18:38 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6635088ffb8sm637174a12.22.2026.03.12.10.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:18:38 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  shuah@kernel.org,  sdf@fomichev.me,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] tools: ynl: policy query support
In-Reply-To: <20260311113550.6b493008@kernel.org>
Date: Thu, 12 Mar 2026 17:17:29 +0000
Message-ID: <m28qbxnf12.fsf@gmail.com>
References: <20260310005337.3594225-1-kuba@kernel.org>
	<177319682153.3014711.5472638473199917370.git-patchwork-notify@kernel.org>
	<m2jyviob64.fsf@gmail.com> <20260311113550.6b493008@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267172-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4DE3F2767EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 11 Mar 2026 11:30:59 +0000 Donald Hunter wrote:
>> > On Mon,  9 Mar 2026 17:53:32 -0700 you wrote:  
>> >> Improve the Netlink policy support in YNL. This series grew out of
>> >> improvements to policy checking, when writing selftests I realized
>> >> that instead of doing all the policy parsing in the test we're
>> >> better off making it part of YNL itself.
>> >> 
>> >> Patch 1 adds pad handling, apparently we never hit pad with commonly
>> >> used families. nlctrl policy dumps use pad more frequently.
>> >> Patch 2 is a trivial refactor.
>> >> Patch 3 pays off some technical debt in terms of documentation.
>> >> The YnlFamily class is growing in size and it's quite hard to
>> >> find its members. So document it a little bit.
>> >> Patch 4 is the main dish, the implementation of get_policy(op)
>> >> in YnlFamily.
>> >> Patch 5 plugs the new functionality into the CLI.  
>> 
>> I was mid review
>
> Sorry about that! :( I didn't see any reply to the one liner for a few
> days I thought you may be AFK :)
>
>> looking at a couple of issues:
>> 
>> - It would be good to fail more gracefully for netlink-raw families
>
> This one I saw, but I figured the message that gets printed is...
> reasonable. For low level functionality like policies we should 
> assume user is relatively advanced? The policies are spotty
> even in genetlink, a lot of families don't link them up properly :(
> So explaining all of this is a bit of a rabbit hole.

That's fair. I had it in mind to work on avoiding emitting stack traces
for "normal usage". If I get to that then I can see about handling this
case as well.

>> - I get "RecursionError: maximum recursion depth exceeded" for nl80211
>
> :o Missed this one completely! My feeling is that we should lean into
> the NlPolicy class more, and avoid rendering the full structure upfront.
> WDYT about the following?

I agree with the approach. The code below looks reasonable, though I
haven't been thorough - I'll wait for the patch.

> diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
> index fc9e84754e4b..ff0cfbdc82e4 100755
> --- a/tools/net/ynl/pyynl/cli.py
> +++ b/tools/net/ynl/pyynl/cli.py
> @@ -16,7 +16,8 @@ import textwrap
>  
>  # pylint: disable=no-name-in-module,wrong-import-position
>  sys.path.append(pathlib.Path(__file__).resolve().parent.as_posix())
> -from lib import YnlFamily, Netlink, NlError, SpecFamily, SpecException, YnlException
> +from lib import SpecFamily, SpecException
> +from lib import YnlFamily, Netlink, NlError, NlPolicy, YnlException
>  
>  SYS_SCHEMA_DIR='/usr/share/ynl'
>  RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
> @@ -79,6 +80,8 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
>              return bytes.hex(o)
>          if isinstance(o, set):
>              return sorted(o)
> +        if isinstance(o, NlPolicy):
> +            return o.to_dict()
>          return json.JSONEncoder.default(self, o)
>  
>  
> @@ -313,11 +316,11 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
>      if args.policy:
>          if args.do:
>              pol = ynl.get_policy(args.do, 'do')
> -            output(pol.attrs if pol else None)
> +            output(pol if pol else None)
>              args.do = None
>          if args.dump:
>              pol = ynl.get_policy(args.dump, 'dump')
> -            output(pol.attrs if pol else None)
> +            output(pol if pol else None)
>              args.dump = None
>  
>      if args.ntf:
> diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
> index 0eedeee465d8..4411f1902ae4 100644
> --- a/tools/net/ynl/pyynl/lib/ynl.py
> +++ b/tools/net/ynl/pyynl/lib/ynl.py
> @@ -143,32 +143,113 @@ from .nlspec import SpecFamily
>      pass
>  
>  
> -# pylint: disable=too-few-public-methods
>  class NlPolicy:
>      """Kernel policy for one mode (do or dump) of one operation.
>  
> -    Returned by YnlFamily.get_policy(). Contains a dict of attributes
> -    the kernel accepts, with their validation constraints.
> +    Returned by YnlFamily.get_policy(). Attributes of the policy
> +    are accessible as attributes of the object. Nested policies
> +    can be accessed indexing the object like a dictionary::
>  
> -    Attributes:
> -        attrs: dict mapping attribute names to policy dicts, e.g.
> -        page-pool-stats-get do policy::
> +        pol = ynl.get_policy('page-pool-stats-get', 'do')
> +        pol['info'].type            # 'nested'
> +        pol['info']['id'].type      # 'uint'
> +        pol['info']['id'].min_value # 1
>  
> -            {
> -                'info': {'type': 'nested', 'policy': {
> -                    'id':      {'type': 'uint', 'min-value': 1,
> -                                'max-value': 4294967295},
> -                    'ifindex': {'type': 'u32', 'min-value': 1,
> -                                'max-value': 2147483647},
> -                }},
> -            }
> +    Each policy entry always has a 'type' attribute (e.g. u32, string,
> +    nested). Optional attributes depending on the 'type': min-value,
> +    max-value, min-length, max-length, mask.
>  
> -        Each policy dict always contains 'type' (e.g. u32, string,
> -        nested). Optional keys: min-value, max-value, min-length,
> -        max-length, mask, policy.
> +    Policies can form infinite nesting loops. These loops are trimmed
> +    when policy is converted to a dict with pol.to_dict().
>      """
> -    def __init__(self, attrs):
> -        self.attrs = attrs
> +    def __init__(self, ynl, policy_idx, policy_table, attr_set, props=None):
> +        self._policy_idx = policy_idx
> +        self._policy_table = policy_table
> +        self._ynl = ynl
> +        self._props = props or {}
> +        self._entries = {}
> +        if policy_idx is not None and policy_idx in policy_table:
> +            for attr_id, decoded in policy_table[policy_idx].items():
> +                if attr_set and attr_id in attr_set.attrs_by_val:
> +                    spec = attr_set.attrs_by_val[attr_id]
> +                    name = spec['name']
> +                else:
> +                    spec = None
> +                    name = f'attr-{attr_id}'
> +                self._entries[name] = (spec, decoded)
> +
> +    def __getitem__(self, name):
> +        """Descend into a nested policy by attribute name."""
> +        spec, decoded = self._entries[name]
> +        props = dict(decoded)
> +        child_idx = None
> +        child_set = None
> +        if 'policy-idx' in props:
> +            child_idx = props.pop('policy-idx')
> +            if spec and 'nested-attributes' in spec.yaml:
> +                child_set = self._ynl.attr_sets[spec.yaml['nested-attributes']]
> +        return NlPolicy(self._ynl, child_idx, self._policy_table,
> +                        child_set, props)
> +
> +    def __getattr__(self, name):
> +        """Access this policy entry's own properties (type, min-value, etc.).
> +
> +        Underscores in the name are converted to dashes, so that
> +        pol.min_value looks up "min-value".
> +        """
> +        key = name.replace('_', '-')
> +        try:
> +            # Hack for level-0 which we still want to have .type but we don't
> +            # want type to pointlessly show up in the dict / JSON form.
> +            if not self._props and name == "type":
> +                return "nested"
> +            return self._props[key]
> +        except KeyError:
> +            raise AttributeError(name)
> +
> +    def get(self, name, default=None):
> +        """Look up a child policy entry by attribute name, with a default."""
> +        try:
> +            return self[name]
> +        except KeyError:
> +            return default
> +
> +    def __contains__(self, name):
> +        return name in self._entries
> +
> +    def __len__(self):
> +        return len(self._entries)
> +
> +    def __iter__(self):
> +        return iter(self._entries)
> +
> +    def keys(self):
> +        """Return attribute names accepted by this policy."""
> +        return self._entries.keys()
> +
> +    def to_dict(self, seen=None):
> +        """Convert to a plain dict, suitable for JSON serialization.
> +
> +        Nested NlPolicy objects are expanded recursively. Cyclic
> +        references are trimmed (resolved to just {"type": "nested"}).
> +        """
> +        if seen is None:
> +            seen = set()
> +        result = dict(self._props)
> +        if self._policy_idx is not None:
> +            if self._policy_idx not in seen:
> +                seen = seen | {self._policy_idx}
> +                children = {}
> +                for name in self:
> +                    children[name] = self[name].to_dict(seen)
> +                if self._props:
> +                    result['policy'] = children
> +                else:
> +                    result = children
> +        return result
> +
> +    def __repr__(self):
> +        return repr(self.to_dict())
>  
>  
>  class NlAttr:
> @@ -1308,28 +1389,6 @@ from .nlspec import SpecFamily
>      def do_multi(self, ops):
>          return self._ops(ops)
>  
> -    def _resolve_policy(self, policy_idx, policy_table, attr_set):
> -        attrs = {}
> -        if policy_idx not in policy_table:
> -            return attrs
> -        for attr_id, decoded in policy_table[policy_idx].items():
> -            if attr_set and attr_id in attr_set.attrs_by_val:
> -                spec = attr_set.attrs_by_val[attr_id]
> -                name = spec['name']
> -            else:
> -                spec = None
> -                name = f'attr-{attr_id}'
> -            if 'policy-idx' in decoded:
> -                sub_set = None
> -                if spec and 'nested-attributes' in spec.yaml:
> -                    sub_set = self.attr_sets[spec.yaml['nested-attributes']]
> -                nested = self._resolve_policy(decoded['policy-idx'],
> -                                              policy_table, sub_set)
> -                del decoded['policy-idx']
> -                decoded['policy'] = nested
> -            attrs[name] = decoded
> -        return attrs
> -
>      def get_policy(self, op_name, mode):
>          """Query running kernel for the Netlink policy of an operation.
>  
> @@ -1341,8 +1400,8 @@ from .nlspec import SpecFamily
>              mode: 'do' or 'dump'
>  
>          Returns:
> -            NlPolicy with an attrs dict mapping attribute names to
> -            their policy properties (type, min/max, nested, etc.),
> +            NlPolicy acting as a read-only dict mapping attribute names
> +            to their policy properties (type, min/max, nested, etc.),
>              or None if the operation has no policy for the given mode.
>              Empty policy usually implies that the operation rejects
>              all attributes.
> @@ -1353,5 +1412,4 @@ from .nlspec import SpecFamily
>          if mode not in op_policy:
>              return None
>          policy_idx = op_policy[mode]
> -        attrs = self._resolve_policy(policy_idx, policy_table, op.attr_set)
> -        return NlPolicy(attrs)
> +        return NlPolicy(self, policy_idx, policy_table, op.attr_set)

